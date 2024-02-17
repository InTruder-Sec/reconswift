import ScansData from "../model/UserScans.js";

export default async function addScan(req, res) {
  const id = req.query.id;

  if (!id) {
    return res.status(400).json({ message: "Missing id" });
  }

  const details = await ScansData.findOne({
    scanId: id,
  });

  // Add the scan url and details to queue
  if (details) {
    return res.json(details);
  }

  res.json({ message: "Endpoint is working!" });
}
