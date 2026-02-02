Return-Path: <linux-pwm+bounces-8026-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mB9kOfSBgGnE8wIAu9opvQ
	(envelope-from <linux-pwm+bounces-8026-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 02 Feb 2026 11:52:36 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A02DCB3B4
	for <lists+linux-pwm@lfdr.de>; Mon, 02 Feb 2026 11:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 614D83004F6D
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Feb 2026 10:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E603559CA;
	Mon,  2 Feb 2026 10:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lUGHUqUT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010030.outbound.protection.outlook.com [52.101.69.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B31285418;
	Mon,  2 Feb 2026 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770029225; cv=fail; b=o3/LvfsSVfX44tcDW6F8Pwg0afOLWpxb2tiYAyYcFVIHMtngpmY8cRXL/HDI1o2Px1B9T4Qiw1TJp0qUB3wFPxUu6Q71lVq5pgMNxemNVFd4qx2jT19rHSvQsX9mP35jAVxkDXAvZ4SqbOVHzM+jBvLmOy0B8N0p1zxp6c4oU9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770029225; c=relaxed/simple;
	bh=dBnhwE8dXIMXjvfuZYYy9HJd5d2KFnSn0gh1Ct0nopQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kMOxdjBRXMvT0uBSoSZH6h+YQLN/smMWfBz8amJtmISd34k8caz2dR1H/AC4LlIj+t0Duo/hVdBdYXZzcATOF/LA5Y+/hmLgejGCukukQWSTiOWm4IWQD+nnzQhD4IrFXoOw3TBIEtMXAQficRzrOzrSfj+XEKdwi4TGJ0idOYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lUGHUqUT reason="signature verification failed"; arc=fail smtp.client-ip=52.101.69.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EfrhH6Ofvc1WeNyuEmcG5Ow3xzHH9A7RVZtAzzdc9lGcLosG7k1aGrH7lQNnuAEIQ+PMpfgNH/vs6d3tB7CAmyrWqvnxQ0NVpOcAmQcLwi2fmNtib6Jx1JuqE2YOa8PBYZtjaY2Rd5EBHQFiOgljq9zXr+58EQa8mmdz8H6GQtHGDN2+1pJDG1Kwm4SMVa40X/ozeZRzE04oc6MsPrwJdWalDb2CzXnTfIFrKUs7L6A9IGjEk0MLyq1PaEnBUYdZ4pkV46cnDAcj0E1verUShI4/Z7D0qWwGcAh+lpvz04WC2E0/fzIbh/C21nMaLTsQ5Ni//nOnJefKNeVxQAedSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KXf1fwiBDL+Qw5g/9XfI37nWFV5ydb6JuevdlB8m9E=;
 b=ftii2xDCI42sQfylqagD3fzktMejDNYFWoOksq4XjDWGHrNKgdVYf5MVkG7yjE9vq1ziLYS2X7UbzFbFj1xEuZECn3rfgApc+HdPriU+0yX3k0kXuB02cDF3kf/gtoYMcb3lXsZ2OJTrBNrd3r+BueBjw88mw7MJUMup2xk+/yeeiY+xyMqlEs4ErBvl2OM52TsKuAJYEn+qsZmAEeIDGwAmsUcBOMuZFzi/WQtfjEevJzjGp3kIXqUjN5vfXDJv7DtOz8/xg4TqmGmgY1bccKUew44K5mx0kjUwNJoLRCQKXwqSDfPdxTGEYhR7sQsAJ9St0+L33x1gWXmcCdbpyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KXf1fwiBDL+Qw5g/9XfI37nWFV5ydb6JuevdlB8m9E=;
 b=lUGHUqUTzAefyJNaxPMKXIU09ctWyFC1eeJ3eRxBRR1S89NWDnLEOm7H++ok5O0Gg6f2YbIrJ0AVl2+qnvNJhblMRizIpWSMi9mgqm6y61iPygMLNz6kFpuRCCpyeeYmFdXnIUfyurIAkq7VGauqfrI+IzF8Ly1VK6zjI66XOhEIULQcRIRkuvjAFit+8Rc9RTe4TuIABPdSidYtQM13v9WhfAuETWo6yUicIp3GP036HPDPqwuVu/safO0H8q+KBN+2I3k3mUVDmZw/iCR6yRpYNL2WK9f4v/ehVgf+rRhYE0/EPxoztUjj2RcbyZZhSnGzEedj7J4Qb0nH3O4ccQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5112.eurprd04.prod.outlook.com (2603:10a6:20b:10::30)
 by DB9PR04MB9282.eurprd04.prod.outlook.com (2603:10a6:10:36e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Mon, 2 Feb
 2026 10:46:59 +0000
Received: from AM6PR04MB5112.eurprd04.prod.outlook.com
 ([fe80::a348:65cc:67d4:1fd7]) by AM6PR04MB5112.eurprd04.prod.outlook.com
 ([fe80::a348:65cc:67d4:1fd7%6]) with mapi id 15.20.9564.010; Mon, 2 Feb 2026
 10:46:59 +0000
Date: Mon, 2 Feb 2026 12:46:56 +0200
From: "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-pwm@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: imx-tpm: keep channel state instead of counting
Message-ID: <aYB_IhLeWjd2mLta@fsr-ub1664-116>
References: <20260130143720.778514-1-viorel.suman@oss.nxp.com>
 <sqpcohdky6m2kz5o7izoclr7k4wi2s72mi4ojrdhr2kbogtfbt@v6y5raizg2n5>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sqpcohdky6m2kz5o7izoclr7k4wi2s72mi4ojrdhr2kbogtfbt@v6y5raizg2n5>
X-ClientProxiedBy: AS4P192CA0020.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::6) To AM6PR04MB5112.eurprd04.prod.outlook.com
 (2603:10a6:20b:10::30)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5112:EE_|DB9PR04MB9282:EE_
X-MS-Office365-Filtering-Correlation-Id: 9829efa4-4919-4bb4-8cbe-08de62486412
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|19092799006|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?TPPqGGqdutojv41ye1FO0X3BcSNxyPQxaENZiPCJYZNKT5JuYVGUsQW7tt?=
 =?iso-8859-1?Q?qwnMMYqgvW/z3lriq+T2ayW4IQqCM/CV7STr7hcfxLh/XHcSMiTdRWW4vc?=
 =?iso-8859-1?Q?3ZG05gOXFvVIuBgcAU3H/VncRFkjxl40NCCKLuZ/+hgMsmp0lJyekDHX2i?=
 =?iso-8859-1?Q?O149yv6mMbiaUKIMbJenSwQARdVMQEcEsHRODAbVpg+ZxzOmaVdLgdtb/A?=
 =?iso-8859-1?Q?86b9nHciifoz0OqhAVESKtqNUKL2hl1qC9G2R+dxepchXGxDgUsCCYcOho?=
 =?iso-8859-1?Q?+r7oqDwr8KEPYJ4+jCob/KYvjR7gleIFAuYdW0KLBetElPeM4RVdgxuBSy?=
 =?iso-8859-1?Q?hHz03KWcUd8CvT2qQPUmiNw/EdRxoXScq+Fy/R+QyKpwjqghEzrm40Vf7X?=
 =?iso-8859-1?Q?g5uYOVC9kWju8tSXw/niEe0JCGmLSpYECPinQHSW7y0zi+mjqLOafFPrUT?=
 =?iso-8859-1?Q?Dg6OyYNcJlkAk2kf/XmZfR1P6wNEtFDch2qJ0Gb7aOYPReXtSakLAf6trd?=
 =?iso-8859-1?Q?KOvItucG+6RRl3EQyG9nqs/Xk4uM+Dt9pNHrlKZVg3bl20Wo4Tkrh0BQSj?=
 =?iso-8859-1?Q?Ut0MMolnhRIYrDhrCM5DzJxTL9GJk23UCsJrAm9vWMFkAb78Uzd3caxCFD?=
 =?iso-8859-1?Q?7Xiv333zcIMo4+9eqi4GKAWYOi7gTlnn7XjvNaZTzlebaU8AAZt4yNIzwx?=
 =?iso-8859-1?Q?VE2fR7t7t9CIh35weG/O1nDL41SgEoLR8icjMD/Q8PmhCo0peIYdbcgIXP?=
 =?iso-8859-1?Q?ymOdY1/r681o5Gf4omMHlrcGL+UbWZ/jTKUMyWsCdYE+8OoC5zx0lDCyQ2?=
 =?iso-8859-1?Q?8UUqUJJXBIra7HkKIL9THkTFH+ak0sAKdpLHqMSSDX047Mk1SZfypXheEs?=
 =?iso-8859-1?Q?n7PNZVE6jpEwpHPz+sAo+ueFJn1OrsNrHXoRotTiLp5Cvt1q8Cm9V5tu16?=
 =?iso-8859-1?Q?j1KaauktHCROomAU+gbGltPduKLnvAvW7A09DfPt7tBa8c3srowLTX4w3p?=
 =?iso-8859-1?Q?sI83hYR7pgz0FIP8VBchCNVURAjVNwxVNGIL9KydAoa5nMSfaFOvSo8RPc?=
 =?iso-8859-1?Q?gEqAoPvARXKNRNROWT6oJNFrgXz6X3yrSxevthdF93/c+Q7KxyXaIxEfxu?=
 =?iso-8859-1?Q?b8JX3t7ZtwRtT7hAnO+G5Os8FIUR91hDheO/rJnTxOXXEDpMgNmRCM2p/E?=
 =?iso-8859-1?Q?kGdFBTpIZgahiLLg7XAW7oJeV3mATsalzEWrNnTiyltop96ywMaJK/L90R?=
 =?iso-8859-1?Q?Zn5VCL6JbBfhgLl1SAiZ6DSV4J/AtsSdBlcKnSBeXO93VnkjEy4Aalafm9?=
 =?iso-8859-1?Q?TuXlK2QqLJwCboGMWC4WEspqPrq3OcglN2O4tp6UvekKPpMcOSt0OIRL18?=
 =?iso-8859-1?Q?4VypBxdQVVvmE+70D+hMVPU6IeE0QdvBblLuoryDAfaSb1mzgM5MYaTzGl?=
 =?iso-8859-1?Q?yTV01DiZXawCZwz1eWRUWKzjmuGc7sK2HWGBv7fzqxHEthkATxYYt4zLbu?=
 =?iso-8859-1?Q?ndsajNffWmxPdtHMI+9gZTQ2GJzUnO9zcDM5nlc3DTW9ZGf9UxD6q96OVg?=
 =?iso-8859-1?Q?NsSsWOf0gOVqsOisOvCExt4EvuJORr9FSYnMVwk8op6+/XUhbSW3XRbdN9?=
 =?iso-8859-1?Q?Cu3pkshJ1Zq0A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5112.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?xjdmr1HbRpQJAgM6BN3DVrNknPCata9iAFqvMwNVJbiC/z4Xxym7+TFkxH?=
 =?iso-8859-1?Q?hTdr3dYmcmWcBPDsDbON+37jwMTEmrTFgI6iL4pmGjp3NkhKDrT2GX2VK+?=
 =?iso-8859-1?Q?4BpObX9jnMSqNEzIvtiRm/cNr7P42d3M0boyJKDOiBoGZcAvgalBTEzvKr?=
 =?iso-8859-1?Q?7xAEsNKfYZ704CKZb17BIlnkwMEFT82xUH+yvW0el0YjPozH1iNeKa2cGT?=
 =?iso-8859-1?Q?4OqeCugYnGXoSeIzvqhllT6T6uWen5GE0DCR8cknBUmlDGfGRWd8ewhySw?=
 =?iso-8859-1?Q?9F8zpIauz9nfj8y/QSIiRhZ6nEnzN3VcnIP2kojpWRLvBRPVHkS7WLBdTf?=
 =?iso-8859-1?Q?iXUBPVIn/tOPJMlHNlRZlyqqQ/BHt802RGOXRtU+DmUhsQ8XHfSl7rNOfC?=
 =?iso-8859-1?Q?X7BLqoxSgp0AZ59/+bXjTO2a2m5VPtEB8o9P4jiPza+SiCKLDOshsOXX6S?=
 =?iso-8859-1?Q?Rzh18fzz7nombarYKZiIUj7KpRGYTopxvzSpsseFG0VhFCEqODwkCCslCS?=
 =?iso-8859-1?Q?/mhEILFz9sacmafyKpsmmdPZLBxc9lfwibyeJJFni1gexwaeqkCfnw0SSO?=
 =?iso-8859-1?Q?0HVlCP5A3Un810KvgB7zlj2nu1fCtybwWo/6toDrmbv3S8La4m3FWRrkml?=
 =?iso-8859-1?Q?2bKdq8QDpTpBFXQDHovCmu9dFjFViAj3W94ABB5htmwx+mscXu4xY6cwBd?=
 =?iso-8859-1?Q?GRZwm08R3XzgyeRRi0oU5nFjilB6sL9DDBJWoCVQ/+z2G9uiE5DaXkDqVB?=
 =?iso-8859-1?Q?/2Ws2CT5sjV8dAKOBen2z23p5UfgLHz/tTllgaPDW1Hge5anwDs5l04nrh?=
 =?iso-8859-1?Q?r1SLYrMfT9EBpjMsndIOx/cLpD2wVPpbq8s0QeG4hvAFpe9IqAgBbjzBXm?=
 =?iso-8859-1?Q?FYrQlqfNrgt9NJ6kAMoXGPYyu+6wXWqYYobIQ/ZhcBknqv1mq69wr9lmly?=
 =?iso-8859-1?Q?1NQm6dcasVsjnoEJb6f9CJqj3NcBupU3/bG8DWFxblTLwA5A0YD3ECWZLC?=
 =?iso-8859-1?Q?DU7RRSud2whK16Ndv76V6PaluC/IwJKoYr84xOt3QxoZlBD4qnrGSrPKiH?=
 =?iso-8859-1?Q?MIFlVGRtaNxUBG/vIKA4KINKhy3b2fqjrFkBRiAgDmdPowaD4IeXIw4Cn6?=
 =?iso-8859-1?Q?weeEp7sS1tDHelJhZtjdVYrBM9emfES1VZnloiYb3BDxZ2AIK52Z8wtZjq?=
 =?iso-8859-1?Q?nIsClX6lakajYzNqvNVCDjc4AB+NPyd94FuKzFTMGi4bpHeJDQfDuJsVdx?=
 =?iso-8859-1?Q?bEEjE715ljIQIQAZFAk/IdUPeB/KmqmkLK1Cui4E3mtRz3AB9bSeCxdqt5?=
 =?iso-8859-1?Q?1HBjhbdwBZuHI7YmybaJx46G6oPrm7gJQI5ktHlfAiabNHhzBbl1v1SvOB?=
 =?iso-8859-1?Q?9nCGN/arPAmaJw0zAg8iZj0CyCEMhWjYd729iwyS0onB4WYkogE039clBE?=
 =?iso-8859-1?Q?kl3wOQj+wYu7IflNspKqkP06EvCIN/jFxL5sBfUMa/sapUs9DgKSw+9gio?=
 =?iso-8859-1?Q?2TafkqTxaMSnKYMuYMbKK9Gj+/lR3KciH1AGIQb1f2ZjZ/aWmJOwvhB0TG?=
 =?iso-8859-1?Q?AysAtqhKYzKtk8fXsv7If1xdBqpoQVsCO8xno3qyePU1wWzkPowP6l2zqK?=
 =?iso-8859-1?Q?kMdDGPs71+V8hbTYxKJaBAFYcNJN8U4JSwCDij0egMkLGDE0TrsHGtxu58?=
 =?iso-8859-1?Q?JKxblH9cySHwseSRvku0R8HpcTIFo1wt8i2HbWHVq9PHQdELUTtRVJllrk?=
 =?iso-8859-1?Q?+q1rM9tfzW7DH220W6ZKuNntSaLvNxsA6pGbeS0FC8QEpN5LqyoMu4MJEe?=
 =?iso-8859-1?Q?y7MMVcsxfw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9829efa4-4919-4bb4-8cbe-08de62486412
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5112.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 10:46:59.1262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A79Dw8Zx+g6CEUNHud9EOYXp6EZM6oL2e5xiDW2RZApH9nshsBTUPGUkMHJmN70n9RmXBOAQ40e80ZFLXSGagQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9282
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.14 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8026-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:-];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[viorel.suman@oss.nxp.com,linux-pwm@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4A02DCB3B4
X-Rspamd-Action: no action

Hello,

On 26-01-31 00:00:02, Uwe Kleine-König wrote:
> Hello,
> 
> On Fri, Jan 30, 2026 at 04:37:20PM +0200, Viorel Suman (OSS) wrote:
> > diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
> > index 5b399de16d60..0f8643f4a70b 100644
> > --- a/drivers/pwm/pwm-imx-tpm.c
> > +++ b/drivers/pwm/pwm-imx-tpm.c
> > @@ -62,7 +62,7 @@ struct imx_tpm_pwm_chip {
> >  	void __iomem *base;
> >  	struct mutex lock;
> >  	u32 user_count;
> > -	u32 enable_count;
> > +	u32 enabled_channels;
> >  	u32 real_period;
> >  };
> >  
> > @@ -166,6 +166,10 @@ static int pwm_imx_tpm_get_state(struct pwm_chip *chip,
> >  
> >  	/* get channel status */
> >  	state->enabled = FIELD_GET(PWM_IMX_TPM_CnSC_ELS, val) ? true : false;
> > +	if (state->enabled)
> > +		tpm->enabled_channels |= BIT(pwm->hwpwm);
> > +	else
> > +		tpm->enabled_channels &= ~BIT(pwm->hwpwm);
> 
> I'm not sure about this being the right approach, feels like the driver
> sells the pwm core down the river resulting in something the might work
> now but isn't robust.
> 
> If I understand it right, keeping the enable count balanced depends on
> .get_state() being called.
> 
> The usual and robust approach is that .probe() checks the device state
> and initializes enable counts and the like accordingly.

Thank you for review, I've moved in V2 the device state
check into the probe function as suggested.

>  
> >  	return 0;
> >  }
> > @@ -282,15 +286,19 @@ static int pwm_imx_tpm_apply_hw(struct pwm_chip *chip,
> >  	}
> >  	writel(val, tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
> >  
> > -	/* control the counter status */
> > +	/* control the channel state */
> >  	if (state->enabled != c.enabled) {
> >  		val = readl(tpm->base + PWM_IMX_TPM_SC);
> >  		if (state->enabled) {
> > -			if (++tpm->enable_count == 1)
> > +			if (tpm->enabled_channels == 0) {
> >  				val |= PWM_IMX_TPM_SC_CMOD_INC_EVERY_CLK;
> > +			}
> 
> No { } for one line blocks please.

Fixed in V2.

> 
> > +			tpm->enabled_channels |= BIT(pwm->hwpwm);
> >  		} else {
> > -			if (--tpm->enable_count == 0)
> > +			tpm->enabled_channels &= ~BIT(pwm->hwpwm);
> > +			if (tpm->enabled_channels == 0) {
> >  				val &= ~PWM_IMX_TPM_SC_CMOD;
> > +			}
> >  		}
> >  		writel(val, tpm->base + PWM_IMX_TPM_SC);
> >  	}
> 
> Best regards
> Uwe

Best regards,
Vorel


