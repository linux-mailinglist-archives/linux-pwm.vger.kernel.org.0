Return-Path: <linux-pwm+bounces-2818-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC92931BD2
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 22:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F27841C21170
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 20:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D539861FDA;
	Mon, 15 Jul 2024 20:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rM3CqCwm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011000.outbound.protection.outlook.com [52.101.70.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926C614006;
	Mon, 15 Jul 2024 20:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721075418; cv=fail; b=u4DZ8fwwsr/kYPHkQFYAt2srb6gwxbpsSSQEJYAM12bYGdI71xX75U4QgNpU4jzsFhC7CxPrw0I+B3Y9FGiZ2c4UIfSQrVG3/O8Sne2QMRECSmFfEiS3YQ5JL9k6DS/26TYt6ZVPXydrfkL5G9vjPV6fZwPZiyQiAB+70Wh/7L4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721075418; c=relaxed/simple;
	bh=EYq4UmROgcf2kp996A2qObnm2JDQgEcIztlzSGwqmwU=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=phSN+ZT0vZarobjIQUxheJ2B1qyYbr3/H9bPPhjqCI2yenk4ldf7WnOxuzSk0DOEMA4yPUrYfJiDnb71SMfqvgkEJYy1Pqnqz28gRRT/U2j/DmNwq5B5b6v0TcEg8O7hYgJw3ObhouFohdzyXV3qhQJkU6uvKC91ds9tatB5pQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=rM3CqCwm; arc=fail smtp.client-ip=52.101.70.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLu8dEJ3+ib2fEV8humRhUTC8LtAeP+L6HOC/Pb5EI7ONsVQAcKQXYUdkAVpang7/JsB+Pdei+wmNdBQPQRlfzs2IoVwwFkd2PlTYvBB3Qor00SpQEqTe8+d0lKLbFoBdJUd9jr51sbuD+q1JuY5lD/Kb+fzfPuws/ABuKHVUT+SU3D/czIuDYGqxXJLkGb3LS/M1Z/ongyQUqB+/dr0kWvgk2X2HJgoIY7C5Y4N1NUQLnD4xad5Q2Mwduy343Jjt/KNku1fPh1vipbvwHIj2RR8YcYLhsH4zBgLZhoB/fF7Z/dQhRpw7G6mZj92im89P6VcPzJUK0dOsXMpah+/Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3LXMhAxy1uaCy/H3lKnkrVBBgWQ5UWrtuj07D+pooI=;
 b=bKVvNFoM6vKIVAnI3M8/Eq/xwSOHx9H4JM4GwNzn3t0ZA8ylOb5mbTCVXibS6GDjJ2deCnDTqHUj0TBIWfItNsb+0ojl7ngu6i6R5sVwX6uePKLvNS7FVALOD6OmiqV8O/fCf94MkA/gRqYyatpzP4qoivsIip6EFModaB+zZqDY445UREOg4w1NnRmZ0BZC2GebyMG7nlEEFx1N44+lk7JWEOGTrr+XO1sBMaYcgIrx1hG8EwsmCjXsJSxHmh3c03cp539UdC5yEHov/orXImcwBbTibN+OGBEFQsMgarVd9Foftybml89hkQynh07VmnFel1ZP+Dh9ygpP4vvW7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3LXMhAxy1uaCy/H3lKnkrVBBgWQ5UWrtuj07D+pooI=;
 b=rM3CqCwm7qOwhbm9XEEZWUQDkePF9pyGfkMvKzVAXpttXTFKphr18iJp8XHPsexwebNiyreRHyt9KTIuC5Cxm+qYb7nzvCid+xXLCO1e/5Kk1X1nM3mt9f2LwkJhepQsJMOCiYpfrkMXIxtE5xozpc5ArruoZjjiblvPFKolTaA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB8031.eurprd04.prod.outlook.com (2603:10a6:102:bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 15 Jul
 2024 20:30:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 20:30:11 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 0/3] pwm: imx: add 32k clock for 8qm/qxp and workaround
 a chip issue
Date: Mon, 15 Jul 2024 16:29:49 -0400
Message-Id: <20240715-pwm-v2-0-ff3eece83cbb@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL2GlWYC/y2MwQ7CIBAFf6XZsxjAlhZP/ofpQejW7qGUgMGah
 n8Xicd5eTMHRAyEEa7NAQETRdpcAXlqwC4P90RGU2GQXLa85wPz75V1Wl9QcWm1kVCePuBMe63
 cx8ILxdcWPjWaxG/9+0JUPwnGWTt1vVKz1mYwN7f7s91WGHPOX0dbRSGUAAAA
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, pratikmanvar09@gmail.com, 
 francesco@dolcini.it, Frank Li <Frank.Li@nxp.com>, 
 Liu Ying <victor.liu@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
 Jun Li <jun.li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721075406; l=770;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=EYq4UmROgcf2kp996A2qObnm2JDQgEcIztlzSGwqmwU=;
 b=OMj1GRCuwOY6n/cmk+3899zZAd2caZQJxy5AUwO84sQHAIxqXqdFNtacv3n21kzE8le0lk2k1
 OQFLhypPsukDYtaLW5h4kwvxlMHQ01+0S3SW/B/MuGWttC3ilMUlORK
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:a03:338::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB8031:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f2df061-9d4b-4c93-0059-08dca50ced1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHRmYWhMY3o2cTV2T1VTY0tjK1U4dUY2clNnMlhmT1piVzZIYVNvM2JpbllW?=
 =?utf-8?B?NHlFb0JFY1N1cm9OVDUvSjFhR0pJLzRKc0Fjb2tWczVXM3J2Y1JpRERySzhn?=
 =?utf-8?B?NitxN2RXdGpvakJHSEViNHV4ZWxaVXV1QVQ3ek9vb1FRbEpLd25tdW53TW9Z?=
 =?utf-8?B?dlc2THdHRVFudTlCVkxvQUMvTElZREd1VWdMT25KdVhpZWphMkNaL3gvQ3Rw?=
 =?utf-8?B?cVR2d0ZZUlpHY2hONVBBNCtvaTlPTEthVkR5QXBYWnZDSTB0NGd3UGExOThV?=
 =?utf-8?B?NnRzSzgzTTB5S29vUDJzSDJsMG4vcjY3MkJ5bTZvRE9HdERGd2x6alhnMEw4?=
 =?utf-8?B?SEtBZGtFaDhnMnNRcVdEYmh5aFQxN0gxeXo2WXNMcHZwc2plYk9NU2k2N0Qr?=
 =?utf-8?B?Njg2ZXhXaDM4a1VUajNoYTByUWc0bGkyWVU2RDVRcnZvWlZYaWlsYThLUVl4?=
 =?utf-8?B?NlpKYllNT3lIVWlxa2RiKy9McTNFTmgwMXVHZ3JDL2ZkQTU0VzRqZDdybVpV?=
 =?utf-8?B?YWdOUG9mWGtsZElsVTNZU2JzK3ZTaGVFUVhFM0ViOUpkM1NMRVlHSFNkQjRM?=
 =?utf-8?B?cG1kWmVqclJWUHVFTFFKWnlGYVVIT1BqYzFWRHp3WjI0ck80UVVQZnFHMURH?=
 =?utf-8?B?SWg4TERDdEZmTC80QktLeTRVVkpxZHNQTmpHQVNhdEtCdnBGTWZmaDRwN2NJ?=
 =?utf-8?B?RWFrc1VxNi9wVlRXTE1GUWVmcldhTTl4UUZLWUZQNjlaWlZwc3k0QzIzOEw0?=
 =?utf-8?B?NGlua2RQdGxOSENySnJKM25YV2R1MVUvZC9OYXgzLzM1VnRndzBSbm1Ldklz?=
 =?utf-8?B?OUx2TXp1TXVVNUJkMExRc0owUEgxMWVCSGo3VUlHVnZ5TnhzK1VxTDcvTU1G?=
 =?utf-8?B?MFNlSXRwWGhUNnhQWkNkR2RuWTFRODZwcFFYMUpTL3hTU0xITDhHVFMzby9h?=
 =?utf-8?B?QVNERWw2cGg1WW1lOEF4aXpwWmQvVWVjVHdWVlBtRTMyNHlaK1JLOFM2WmQw?=
 =?utf-8?B?c2V0RFRLZmpNOGpybS9VMFVSaGl2d2x6dEQ4ZkRaZmZpZURWblFBRXlJQTBs?=
 =?utf-8?B?dzFNTzBKbUpVVWxXb3ZzN1A1MnhOamphek44Vml6Yi8yZGY2VTA2MnR0SXRL?=
 =?utf-8?B?dEFkR1hqOVZINXFQS014dmFDVURMRnRvdjBFb2ViTENjaEJtUTkxMDdKSllO?=
 =?utf-8?B?cUNpbFd6VE56RElhQlRpc1UyeTVWM1c4Zm03QWVwVDBtVHhBR3pUeTdEbmRH?=
 =?utf-8?B?TDlSR3k1MmlQMWJZZWsvVGJkVFRrdnF1Smh6UGt0OUNNUVdOVlBuRXZ2ci9T?=
 =?utf-8?B?UVlIM2JZazJ3dndldjhwZ21jKzBjMytQaldoTldVb1lGU0pIWk42K2ZjVmxV?=
 =?utf-8?B?YUZSaUUwSVVvbFFIRTdJRHRUZjVUREpTRXVqS3FDeVN0VE1zNlpqcEtaUVFv?=
 =?utf-8?B?SGowcUVqOHVHblZWRngwMFREVXhZeHltRG0xbGpMcmYxTUdvODZuNG9NYTdX?=
 =?utf-8?B?T2pvUlZwT3pqVkkwcjNSMGhOT09xenBGejRGQkN6UGV5ZExicWU2cE1YVmZI?=
 =?utf-8?B?LzhqU3pTM0VQSnVIc0tMeGMvZ3NGZmdkalNRNmg3Y1JXNTdleU4reWJoYmpO?=
 =?utf-8?B?dUdzMGZqNGJsbmovT3NuVjNGWlNXdnVDOC9KejJ4SVB1T3ZSQXlnUmVGV09j?=
 =?utf-8?B?V2lJcDBpN0ltVm03Y28xTHVVMTZRRHQ1eEpualVYUzFTWXdKVHRLSWIwWVF6?=
 =?utf-8?B?VmNXSEJpM2M5Yk5FdExOTGJmOHF1R3N0anp0VWZJbkRVdEgxSWZBRDhEWWlk?=
 =?utf-8?Q?2g6uCz2A8Hrj/UGOnxMR7rk3jUj5yT3oTjqNo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjFZL2Z6UU84RHA0anBTT3I4b3pYR01qL0gxckg1RFRyNkxOcGFoNUlISU1S?=
 =?utf-8?B?SjNQV3pBSG5rMVFRU1hnK0NMeC94Z1k0TkJoYm0xRTJIK1piL3h3MlcxcFVu?=
 =?utf-8?B?dE1wT2N1UG0weThkbnVMbmlHNFRJYjYyeDJBVTBFYlpxa0RUR0FYQUpiZTEv?=
 =?utf-8?B?bm1LV203aks0QVVydXppYk1CRHFYUUtFaFdVYXRlMk8xek9PZENVczcySzYy?=
 =?utf-8?B?MGUyajJYdkhTYjhSRjExNFA5eWg2Z25wQlBESWt5eXJtSFh5eFRTU0VuYVBM?=
 =?utf-8?B?TlI2aHFNMTZEVVJxMGtKNThqNHRkNnNTZHdYNjV4Z2pSR3VnaUFSZUw0M0JW?=
 =?utf-8?B?ak1YYzlINk95MVJ1REprMnNRaFovUjdJVDdVKzF5d1FyWG1lZjJZOVVsM05U?=
 =?utf-8?B?dldMaCszMnJ6ZjhEWmc1OFVlZXYvaEZzTlZsNnpGM1JDUGM1MzNBNzgrNmxo?=
 =?utf-8?B?LzJma3JwT2hqbFpWNStGcUx5L2VrTTBTSnRRbTc0MUh3bHRMTmtYblNDNFVD?=
 =?utf-8?B?MDQvOG0xb0p0R0p0T3ZmdHZabGJpWkgvRzBsbXpQd2ZqdFJIMC9SSUkrODVU?=
 =?utf-8?B?Sno1RUZpbURIZHVQdEV1TXVSY1F4QXk2QmF5em1HSjEyN3dlOFg2UVV2MWhI?=
 =?utf-8?B?MDI2S1ljdGxidXIxUG1XeCtXM3dFM2RkbXZLZ05ycUFPcVE5Y3FjUHlCYUxI?=
 =?utf-8?B?MkU0WW5vZExxS3NZSzZCSWU0SWE0Y2lTSzhIdmF6MzdVMVBFQWd5czdkRnRD?=
 =?utf-8?B?UENiMVExVWVHMkk5NnM1NTNERjh2VXdqeXJHd1UwNytnYzIyRnZFSHU3SG1q?=
 =?utf-8?B?UmZKTnVPWmlGUDhVMnpiL3FmSElMRHg0aVorZ09RVFk1cXRhSGxEcnlMQnNC?=
 =?utf-8?B?RVd5djBsS1lMa3hYRTVweGFrR1Nac1VSQ2NUcTFxRkd2S1Q1SUxvbmg1blIv?=
 =?utf-8?B?RmJSeURmMDlQT01LaVZGNy9kQUsyU3U3SmV1N2JaNUV1SjZ3VlM0Z3p5a2hw?=
 =?utf-8?B?SndiN3U5d2tBVHFoUzhzS3pHSjRVVWl0K0ZvRXRmMDRxaUFONHZpNVNKaEVo?=
 =?utf-8?B?aC9mUTVpMUlwY2dyUUlqM0s2RWZJQXhTOUlSaXNqTURYUWVIdTVtS1VJdEhw?=
 =?utf-8?B?MFFLWHBhQkRjWHZrMTEzMG5qODNYWkJNSEMzSWpWTG05K0ZLTmFvUjRlME9M?=
 =?utf-8?B?Um9ZMzg2NmNRR2VRMldGOUFtUWtGRTdNVTZkVVdnSkFpVWxaaHZMWFVlTG02?=
 =?utf-8?B?QnlmaUtxSVZBclhWZzhuaVVXWFJyc3BuOThJaVpqVlN4VWJlb1RVS0NOZUVr?=
 =?utf-8?B?NnVqMEY1N3k1ckNVd2Y2MzVjcTZwSzhiblhBVWp0bVFzZXNlWTJ3bTY0ZEw0?=
 =?utf-8?B?NHYvUDNIS3JRTHMrSkw3R0xMSHRBd2pibFBoOVc3ZVRjdk45TGkrT3JGOEE5?=
 =?utf-8?B?TSt2empIakQ4S0Q3UWN6QjBJSHJva0NhZC9uSU9rRkdsbVVvMlpCL0FVN2lH?=
 =?utf-8?B?Q2psKytTSWxQaTdMV3ZQWENNVU84OXFWajI5cTZKRmxIOEEvc1RiTUxVU0Y0?=
 =?utf-8?B?Y1hlQ2dSVFkwWVlqdVdtQWtGMmszYkpaeVpGaTlkWkp5d0NpdythSnVlemJD?=
 =?utf-8?B?VTlHYTIvUVZJcFdzbWpoajdWY1hWMDlndEFJR1h6dGVSMWxQb0h1UVU4N1F4?=
 =?utf-8?B?YkJxbnZPYXdDMHMyVy9ncFJ1SGtiSHJ4SlhwVVFiTHZNYmdiOHlQZGt1cHpW?=
 =?utf-8?B?TCtiQU03WC84eXFsYm4rRVRVMW4rcVRTUnRsZkJGYXBtQkF2M2FEenpPQjMz?=
 =?utf-8?B?bkd3ZTJjZmhCWk9GNDBKOHRmNDFLeXpvWFRwMGUzcmtycUFTMkZsTU9uWFFW?=
 =?utf-8?B?ZTVFRlhTdndxYXpRZDk5Vi91WnkxbFRjcEdhM2xpNFBnY0RqTGFnVEtFdjNw?=
 =?utf-8?B?cXQrcm01UWd3U2hVNXdDV1FzcnlkLzU4c1Z0enVWTlNmbzF1b251cU84TWNn?=
 =?utf-8?B?d3B6aVc0b1dHVlVyM253aVhiL0V1YXFtQUZnRC9hakZyMlhGcjg1U3FHVVEz?=
 =?utf-8?B?WTRSRiszTGRsWGRXYk0ydE0xZXVIaCs1SkE5VTljSk44YzdvSzRoSDZwcXh6?=
 =?utf-8?Q?CUYA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f2df061-9d4b-4c93-0059-08dca50ced1e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 20:30:11.7176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jz0HFpvSIlJRrr1Z6XUTwLHUN5yRMcXnyBAhYMMrFCunDvFeKpVDaa4bhzH7gmdhmPF140+Hbsl+3WsDdrjC/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8031

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v2:
- See each patch
- Link to v1: https://lore.kernel.org/r/20240711-pwm-v1-0-4d5766f99b8b@nxp.com

---
Clark Wang (1):
      pwm: imx27: workaround of the pwm output bug when decrease the duty cycle

Frank Li (1):
      dt-bindings: pwm: imx: Add optional clock '32k'

Liu Ying (1):
      pwm: imx27: Add 32k clock for pwm in i.MX8QXP MIPI subsystem

 Documentation/devicetree/bindings/pwm/imx-pwm.yaml |  4 ++
 drivers/pwm/pwm-imx27.c                            | 78 ++++++++++++++++++++--
 2 files changed, 76 insertions(+), 6 deletions(-)
---
base-commit: 472fa0e0d7d03574177fc83dc15ad9da15db4ce0
change-id: 20240708-pwm-5993e602c9b2

Best regards,
---
Frank Li <Frank.Li@nxp.com>


