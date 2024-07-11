Return-Path: <linux-pwm+bounces-2766-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2113A92F0AA
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Jul 2024 23:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55152B218B1
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Jul 2024 21:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F390419EEC6;
	Thu, 11 Jul 2024 21:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="r7S9a3AH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011027.outbound.protection.outlook.com [52.101.65.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8772836A;
	Thu, 11 Jul 2024 21:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720732168; cv=fail; b=H5TzRJkZCt0vWUl/KxKn96+lVudDS2AbqDHen0u3Xsb2YrhDftWP221akAgzdm5GPoKD7/TpMuolXC1bFv/njavf87IZh3h4FH9+ro/ToIMe4+YA0tJZ+JaQBF5Ns98rRDpmCzfaDv2NADawLfBls339ywYrJuk1fm+4GQ6k6K4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720732168; c=relaxed/simple;
	bh=GLxyVDVzcZ3UEl8gtKcSzBScsOuqQDWNx2DhjQXwyuI=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=rux6H50Jx9Op1FQm+9tg3HjTC8F7DwPkTA7xy0SW2HQ//mMfkpmyZ2uzH5zZQgSZJV5+eGhlQOsmT2P8KL+GshVMR8VluLI3wU3VxIzfpgLA7UNzzprD+ttlAFZHpIau3DI6PKmDn1J5QkWfPMldzvjy5KWFGp6r5iO0mG4WutQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=r7S9a3AH; arc=fail smtp.client-ip=52.101.65.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iFjX5lXq58AGnZRcoVIRISasaZ6kiUPC5lg0N63OJRDjx2xuuuGM0j5R/c4SbHQpZKeMU9HYBwyIsJQdrir7jqiZ9eV7VOMESXKDxz3MvamQbaA3gs/o6pv1+BJcwBodf3lTxJyiUWHOl9DVtB2qBnKob3UyquDPn5AzqoYHYyrtl59dxy8kuytNQgFOUqHRR/wGtdDzvcK+cbi6jESy5DxDgvMJJuOI0+IKfRv9vm3O776CzHndPauc5EbGlPCuogfg07eDDswTTX/2jKZZ2zsAtJCUvYaUGwEPkVBVkxx0XJ9uuoeaNPuq4wtRdlaTJ+G5OWLhGhcd+czLs0RFuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfqz+J11kO/oG2BWriRE0KCStDpXutGXgdlRzqyeQxU=;
 b=lb8wwINDERfCILvo6jL4jFhuayFa0t+YneYs+SRH03uGjyXNVOVHsNjEdAPBVEG0t4kJmW/UGu3x8HRW2oVOKSCH5cM2uoRQn/GnZ8ogRwYQIYbA1cYfV5H5qiH1lUIMaOMZSiZ7JLv8oxCckE7rg9nQOd0PbTD21sbf73nxfZjXVPrTBkEzNUO2BWPxhAMf+vXwSOodYLB9vggnvnZ1CUghLsGCco1EJTbP6pzRr4SM0FKDUdSjxiX/RCjaJ+2kwFeROjnwC48BcMxEA9vq3hFtzSPfONquqz0+M7x2Eym6sv3MzR4G7zbuXGc40a3yUqb34xbWccocHEX2TxNV7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfqz+J11kO/oG2BWriRE0KCStDpXutGXgdlRzqyeQxU=;
 b=r7S9a3AHyCZXyNk63rCmvjyC6Uf2DBj1p2YvvpHv+kP1rHgOmvHzjHCRFMcX/4tnumS5WCmPckCBaO2+j9RUkxu4fak4l8ODUiakYdVzj563+8pExulyPHYyxSiJfymMP85i+ZcMfozo12dFODxqLN8ijHMvXhb+WXEAUredFJ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8753.eurprd04.prod.outlook.com (2603:10a6:20b:42c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Thu, 11 Jul
 2024 21:09:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 21:09:22 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/3] pwm: imx: add 32k clock for 8qm/qxp and workaround a
 chip issue
Date: Thu, 11 Jul 2024 17:08:55 -0400
Message-Id: <20240711-pwm-v1-0-4d5766f99b8b@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOdJkGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcwML3YLyXF1TS0vjVDMDo2TLJCMloMqCotS0zAqwKdGxtbUAwbHbp1U
 AAAA=
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Liu Ying <victor.liu@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
 Jun Li <jun.li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720732158; l=670;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=GLxyVDVzcZ3UEl8gtKcSzBScsOuqQDWNx2DhjQXwyuI=;
 b=2CFmPHUO5gRPqcrfevbLtg3QEgScFrEUIk4xOSiGMMjWGg3Eg/1y6FPEfo7pUwB108eQGSVD9
 eagv46Eu5DCDIfYhJiFsBfVrc9L+H5ZbTF0fCnAU10/iVbM/g5yDiAK
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0234.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8753:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e647e3d-37a5-43fb-def2-08dca1edbc99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTZ0TmhTMkZlWWRML1hVZHM1aUVaNXRMd3BmT3JYY3dnSU9td0pkTXJMMk51?=
 =?utf-8?B?OGtteHlCVVg2eEFWZjh5cEdSZWFRakFISGV5b09kQmRBVk9OdGsveTAzK2RO?=
 =?utf-8?B?L2U4aGNhajM1U2VVWW9NZGhoa1c0b0NXQXF4OTZuVUFOVzFsY2pOVE5VQmxz?=
 =?utf-8?B?bDloTVo3WitaaWNqYTFLV0JaMWhCZ1dZTUdveVhrcDVXbytNemRTOGwwT1JD?=
 =?utf-8?B?NlNrN0N2UEJSaHZrMDhlVGkyNlFMeFZQeEY4ekVpT1dLZFBTd1M3VHBWMkVo?=
 =?utf-8?B?L1RTSUlrTTA4WXo0ODJHcGJPcXA1clgrcGZNbjNhUjUwNzVxclNrT0RSMXAr?=
 =?utf-8?B?OHJEcWVOYWxHZ1RvK1RNUlZFb3lrdkpLa1lDWXNlUFFnTXcrU1hHaFFuNjBI?=
 =?utf-8?B?azZiK0JCVm1XZHJPcnppeEhuMm10aC9JUURnMndCaDRjYmZIOXRnTkc1SUNn?=
 =?utf-8?B?eTl6VlUrYUZFZkgrSmVzSjR5K1VVTE4wbklYZDR4cDFLV2tHakd1N2s3MERk?=
 =?utf-8?B?YkZmb3ZLRldqQ2ZiMm41czZITS9rN2hXSS9VM0svTDJpM3ZPSmxFUEpMejE5?=
 =?utf-8?B?NUZmT0NUVTFTc1Z6UjQvV1IzWGREOUl3UkJEemhPVlV4Y2JBZ3Z6bE1ZV2Fm?=
 =?utf-8?B?NkRCbVRUVng1SUxQUmhqZHF2aC9yQU52YWpnNzljT08xZlBCQk5yQ1FsM1d4?=
 =?utf-8?B?a2xkaHk4dFlKZ2ZCUklBS3d2V05jZTFESlNTR2F2bXBuUlhjZjRoaytOWVN2?=
 =?utf-8?B?ckp4dlZ1OW1jOUNiU0RRTGlEMnFUVW9XNWo3ekZtakhTQ3VTT2pQWSs5Lzhj?=
 =?utf-8?B?UjRwZnpiWEpZUHFWMVMwN04vZE5tOURVUVVISUN0NXNtOHpBY09Ta3JTaUYw?=
 =?utf-8?B?b0ZBTlByajVnQ3dtLzRiaHE3anFIcTZHbkdCRkpwd1pDWnRRekVlRWorMnp1?=
 =?utf-8?B?RERWTXprUlpMWWZQWGRnamFZcVVNVzdmOWNwdzdYSkhiZzJuQ0gxcVdaVVpH?=
 =?utf-8?B?NjlVL1c0eWtmZWRqOXM2ZmlZSzdObzVRWllqOXRTMFU1WklXVFQ5T290RVFh?=
 =?utf-8?B?YlBOTGJJZGVDTitJTStIYkRkWVJIVFBPMG9SNlZMenk1azBMMHllUmVwL2lO?=
 =?utf-8?B?SjZKWmh5ZFBGK1FleVQ0Z3dDRWEyOVVGSTk2dUhCL2NhMHZYckVMV0lTT3pK?=
 =?utf-8?B?MnB1K0R0QmdmemhKTWhQZHJaS2V5ZkxmT1RqTUR5ZmxscnhKRmw4RzU5K3l0?=
 =?utf-8?B?K2RHRDc3eTIwaFFuY245NGp5UzA1dHhIOVgrUmVPOVhtWTJHdWJlSnJGSGM2?=
 =?utf-8?B?TFhNOUdIQmpXSHNLK0QxSjVMYUZ3N25iMGxUeWw2S2xrZ3cyellabU0xZHo1?=
 =?utf-8?B?aUszdWJkR0QydEdyS3BWWWNkMXY4YWN2K1ZuRy95SnNLZXI0a015ZFVreTk1?=
 =?utf-8?B?RnBTeDkxT0QvMFZkVWNwdnhya2VCQXZXRUlvUmhmQ25nOG1NQW9jYXg3TitD?=
 =?utf-8?B?MjJtUnZPUWUzZ2h5Q05ZeHpTTWFweXRDaGhDaHQyWVJTdUk1dWpkekdVdTd1?=
 =?utf-8?B?azg3bHRoRFQ2N0RaYzZxWTNVOE1adXk2SWgxU1NxWnpjMEpJeC94b2xZM044?=
 =?utf-8?B?VEZueEtsM002dm9SbitiQjlRZzhlbnRmOUhaRElyVmEvdTNuUHMwOVcwa29D?=
 =?utf-8?B?ZHQ4OFpWNUovMGIvNW1tUGZ3ckRlcVN1NlRuaWluV3VqVVE5alNneEt6dHZ4?=
 =?utf-8?B?K3RYQU9jNGt4aS9FbHRQYmRMdW5FQ0NXQlZlUHdvd3BRVnhGUFNHZTFUd2hr?=
 =?utf-8?B?MlY0b3BjNVhZNjZTQkVBc1JySW1QMGNRZnNuV0NRNDFMeHYxUkFqNVFObEN1?=
 =?utf-8?B?TUkwQVZiMWxtNkxXT0xQc3BtVGpPcGxrS3VqdU4vNEdCemc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bURPKzVSZUU3ZUF0dkUrSHFnUncrcFBiWTBibG40dkxSbFBZR2VzRWU0Rmhm?=
 =?utf-8?B?VFZGTDVsUmpUM2RBOHlWOUYvVEpSVzhnTitHbElsQWVmZjBoVGZQa0hoZTNG?=
 =?utf-8?B?SVJFZ3BabFg5bU15Q0lpM0ZmT3JkQnVBblpiRkRTTDRVOEFLQTZLaFNQNUZB?=
 =?utf-8?B?WDBuZVZwbEFtZnE2bDdzYXZ6Ym9kMjBiT0VnMGp3aGJweEkzNlRHa0dueEhy?=
 =?utf-8?B?Wm1sWVFpSVBidGNUS1lFaHY2WkVUVjVISU5KRWttZ0U5bC9pU3AvMGJtSjJO?=
 =?utf-8?B?dDNmNEg1M3QxbDAzeXhTcWRSK29IZ0JpTC9sMDlOZGZ6eFBKbit4TzhCdnAv?=
 =?utf-8?B?MDRtV2VRTzJmUkYydFhtbyt3Tm13TVc2TEtUeEQ1SGVMaVNYVjBZeWMvTkp0?=
 =?utf-8?B?UFM3OFBFakkxaHRhalB1ZEszTjgxVEt1bm1JeGFseUdaU1I5cVJSNHBSanQy?=
 =?utf-8?B?MjlUTDdoME9LOVFudml6WW4zNzRKUS9pVjVCRWFodDZUQmg3MnpEOGlEVlhY?=
 =?utf-8?B?YkJBMnEvMnBoS3Jld0FTSG11STdJRGhqVkpzOUhmNTYySCtkSnhKSURkVjJK?=
 =?utf-8?B?cGFKSW1aMXdUOUxLTVJaSzhaQlBFZFJUUE95UEFuZ3IxdHlWMFRuM2QyM284?=
 =?utf-8?B?ZVRpMWlsZzVrTm1TRDNsQkE0bkZJaU0va2ZvMDBKSk1qMy9yeTZsVm1EaXlF?=
 =?utf-8?B?TDJPR3huMGRxMmcyaXI5Q2RpTVYrQmlNQ2RyWEFMdTFXSExEZW1nYTkwOE51?=
 =?utf-8?B?cHVEdU1XV1VPcXF6NUk3TUk3YUMzanZNcm5VeHBYSGZTTzVHc0M3ZzA0VVRQ?=
 =?utf-8?B?Sm5SZ1lOaW1GVk56ZWJrUENkMnd3SWtQbHVBVDQxV0ZLcDZJamJPdVo2dTBB?=
 =?utf-8?B?ZUdheVdoTk9yT2dZVUdLcHdIaG1HMm05K2ZGUjNmdzA4Mk1MN1dTMUcwSmJH?=
 =?utf-8?B?RnJLRjJvN3RKWVY4ZXRLdXJRQU9GWnd3YkdHa2pGTkpEWUREalUxRTVkOVRx?=
 =?utf-8?B?WUFKbGwzcjVCdUk0NUY3clcxMkk0enVhcjdsZUZ1N0NVcWJvd3k4S1JHT1NB?=
 =?utf-8?B?aTQxYjA1Nll1OVdFYlMyYytJVXlsaCtnWDJkblZNRWlVamExOVdvZFBHRXBN?=
 =?utf-8?B?TEdMeGF0a3FoYzlhMzlhclR2N0lyaGVEcHlJUDJIMDlHVCtSdDBLNWd3d05L?=
 =?utf-8?B?UjU3NWNwc2FMTEtmYUhUd2dZWWp2ejRvNGhoZTY4VGVaZmd2VVpEaTMxR3hQ?=
 =?utf-8?B?UURaT0t5VktBZEE2K3ZLVEFrMEQxZmtBNFEzNUpldFd1ZjJibkxEbGhXeUJx?=
 =?utf-8?B?N0YzU016bmhScVB0UUdRN2VkU0FJditJRThDWUtPQlczdXI5SWtFZFNVeHU4?=
 =?utf-8?B?VE1aeVEzMTJQVTAyOGREdDVVdUpVMktZL0tsaWxKYkdETUxYR3hRYWY1RXJv?=
 =?utf-8?B?ZFl6cGI5L0RNOVVXT0lsajZ6Z1B2bVJDY1VCR3JlWmNtUDRvWi81MzdqWkxv?=
 =?utf-8?B?MjBYUTRiTURpTVd5MnNGWnRlT1JabG1rWjV2STlQbTkvUFdmSlRySU94OXc2?=
 =?utf-8?B?eTFZM2ZIUFc5cFdkQ09RKzFiOFJGRXFWQ2xHNVJVaURzbmhSTlFaY1pSQVFZ?=
 =?utf-8?B?RVJWL055WFFndk5pb1BTL2hnWFhDOVRkN21GRmtDT2NVOGlwNHFwcWtCQW1Y?=
 =?utf-8?B?QmFuZ1F3Q0pxZlRrVDRHcDM1UDhrb0lCRDJuaUE5WDRvUVZONTJPTGJRNmxv?=
 =?utf-8?B?a1FlRUswd2JCUktTejFBV052a2x5M3JLand0bXJsLzNWRWtzYTUzR2lsZjJU?=
 =?utf-8?B?WkNzOUJMdzFURHp4SkpxSG1kSjdsWVRZdzV3M0ZkNTRhc0NQdUVCeEZ3MEJ6?=
 =?utf-8?B?cFZPSlVpUE91eXJqYTBBOGpqZ3JXMmRETC9yMjJDRStLM2E2cC9GMFU5cU5S?=
 =?utf-8?B?dnA1Wm9FVzFqRjBsZTl2bzNtSVI3NE9HUjlQSkJtMllNek5tdUEvd3FHSUE4?=
 =?utf-8?B?RmR2K0w0Si9BdDA0TFdUVXovcG9MMUVDcVVva1E1RVNQRHhmSDAwd2k0QTFq?=
 =?utf-8?B?Y1Q4WDFtSmxUVjkyT09QSGNWbTZIMXZMd21BQTBrSmJ6aU9jZU1TalR0dDVW?=
 =?utf-8?Q?eZqWpnBxwKx5+EaE8cGx3UG5a?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e647e3d-37a5-43fb-def2-08dca1edbc99
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 21:09:22.4407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7RVXqhO+3OSkm05tX+VIkGYS4vaRt/N/HJncsPhxfByMG9zVlsM34BiEcgEuRXqkMSlEFm9mIKv3+Vu4Okajcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8753

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Clark Wang (1):
      pwm: imx27: workaround of the pwm output bug when decrease the duty cycle

Frank Li (1):
      dt-bindings: pwm: imx: Add compatible string imx8qxp-mipi-pwm

Liu Ying (1):
      pwm: imx27: Add 32k clock for pwm in i.MX8QXP MIPI subsystem

 Documentation/devicetree/bindings/pwm/imx-pwm.yaml | 29 ++++++-
 drivers/pwm/pwm-imx27.c                            | 88 ++++++++++++++++++++--
 2 files changed, 106 insertions(+), 11 deletions(-)
---
base-commit: 366b147e98c933f02176e84d73eea4b503bc5362
change-id: 20240708-pwm-5993e602c9b2

Best regards,
---
Frank Li <Frank.Li@nxp.com>


