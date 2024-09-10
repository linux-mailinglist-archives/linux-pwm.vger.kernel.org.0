Return-Path: <linux-pwm+bounces-3193-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FDE97431B
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Sep 2024 21:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1214128A475
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Sep 2024 19:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6F31AC430;
	Tue, 10 Sep 2024 19:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ewNIZjD6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011014.outbound.protection.outlook.com [52.101.70.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50081ABEDB;
	Tue, 10 Sep 2024 19:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725995276; cv=fail; b=C9RWAK+bv3aVxyEb/kO1uipBjHiU+IwE85a2iPqTRk6kMH2IuMnAYwAp1l7enFSVkZce8z8VJNrj7HgOI/BeBTbX6grqBJ5O7KiBgnlDSHTeZA+0oIxjhC/yI/1iH1dXIC6hB92JrjktkG3ITxr6yzt5CKz4HQ7b1Z/v279ztSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725995276; c=relaxed/simple;
	bh=Fv/rjc6K+Tgi8oLugRWIWJNXxGBfq8oLj375Kdahgzk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UB60f205vOACOAv/eV4hyvJHZ9RN8ApQgLGHN9n/IU1waZl3CLuhlmWhi6+0CGx1SVwD+1uUqKgOXK1VnlQSZxhWrpOmErTffS4nl01ppPcA7oHZNwKnN+bk9UjZaPho1jf4SQ+ZdYg+kFmr7/g/8da+lHDXLw2/K4RxPzjPtBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ewNIZjD6; arc=fail smtp.client-ip=52.101.70.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDvlDqsiayQ4hyOQv/34HSiCfVQV+X08NzZCgWwbJC18SS6s1KTVaa1NZs0lNxS0837op18jXHJqx3ib8mXZ/C89+Cv0FtQ4oDEzQ6a+Z7+QG12fJ1COfp4/U3gJAqLel6Mh0aF2L8qzrto/uUh6VhfpDdUpqxE3DyeLqDgAcq37bU/yxE0Uy5R9sQsQnI9ie2FKxTpIOmAMtvSkwD58gEGry89Ymsb/OfZwlpFLbBl7PQU45QK1wINMqXEixR03r4tZTP1OskYCIISzcyIedA3od87phFkP8zo8PSzuZMOWdi5TK0cJGis0EVrcYsh0J9f7S9yuyr2sZa85jw/Wwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCtkPEOKBRoUNpB05Iym30l5jBGSebnuQxLOOU+RHjA=;
 b=ZIfhrPRdujTRCKtUczVpnpOkV4vTSxnpmLw9SFkay/kUeJDa6O8mLHvK9uCuZuo/GG8ZGug4cCLQJNV20tapSS8CzhOOc6kSqbLdB7Ay3uir5W+1wex+xUV2IqZfl0IstzKdgXidgLQ3I5gDTgWnm89CaJj3G9bQ3/VKVbF97NcG3LxgwsO8KhB+qX6l9blT+qUJ7rn5BqdaCM60sicdkKiP0KuZoRNbUbohCI+SrU/DpufK9KEglGDia0PSULUqQ3E2XZOircT8yKIP5iNJkykq202pHbXZX685/wUojmIFMFp/Az2LxIQ0Gix1r9Ccht9eO28Q7MABa1sHaVmgAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCtkPEOKBRoUNpB05Iym30l5jBGSebnuQxLOOU+RHjA=;
 b=ewNIZjD6NcYfKkYu3Wns9m6Ic2N8SBH5BrhDrpGon45RzfLF2O7DXE8Pglk9LM5+I/WHq+56WwvKOcqgJchbd2XM2yZL7btMIB450IrRzfxZletbsEdVxOc/VJ7/z3VGBKe0FyIkr+rRttGrwFcFRJD8t42jj8fdszY7k5MHSUNpHmeldWUZcR76JfGtZJNZ7uLxqR4Nt5kR4cCX5iReeT1xvtSgQHMfEFVjI3xTx+2H0J2oyQnQYtNUeGlW6dHcx3MlyVP+LPT4sdDsyfqoEOmvcgn7dmtz+1flad1uLHiV4EXS9X23R7/do5QYUHrZia4SPpr27Ipzticq5TOCTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB10115.eurprd04.prod.outlook.com (2603:10a6:800:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Tue, 10 Sep
 2024 19:07:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 19:07:52 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 10 Sep 2024 15:07:19 -0400
Subject: [PATCH v3 2/3] pwm: imx27: Use clk_bulk_*() API to simplify clock
 handling
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-pwm-v3-2-fbb047896618@nxp.com>
References: <20240910-pwm-v3-0-fbb047896618@nxp.com>
In-Reply-To: <20240910-pwm-v3-0-fbb047896618@nxp.com>
To: Marek Vasut <marex@denx.de>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, pratikmanvar09@gmail.com, 
 francesco@dolcini.it, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725995258; l=4875;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Fv/rjc6K+Tgi8oLugRWIWJNXxGBfq8oLj375Kdahgzk=;
 b=90s3Uzgics86Z6o3Iv4aNOpDLSGdNdKlOXofzw60xM3AW2vPOLSZfG/NPlWTEer9h2mF5ypWD
 n62gBae1B5gBJyui0M2Y1lfosNwzY+wm0s7KYLQFG0qfOInhIrQ6Mac
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0145.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB10115:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b708ad6-8efe-481d-52cb-08dcd1cbde5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1NFMHJaYktLeFdjR0Rxc0J0TEw0UDdIL3UvOWNvR2lKbjYzellZSTFsbnZv?=
 =?utf-8?B?dFJZQUFWYlc0VnFFalEvYU1KcDdKQkV6aGdBWDlxcENrM1MzQ2RwdCtURW1J?=
 =?utf-8?B?dW9DT0xEaUdFVTRkdkhYMFpSNjhtQXJVU0ZQbzNkcVc2dGIyZk5GbnRud0k2?=
 =?utf-8?B?NVp1bFB1ZFEzZWwyUm5FVHFGNW13TjdKRGdBdkhFUHBUZVgwZE9BOCtNT3lN?=
 =?utf-8?B?a0tOQkp4NGxnODZOV3UwVDhSOHp6NUdOL25HN3F0SWVIbkpOUURxWlRjbFpG?=
 =?utf-8?B?dHlvSXRIUlNCVFkyM1RodktPb3dlK2w0YzFCVjh1TUx1aVNUWnBvRFNxMDhI?=
 =?utf-8?B?dFFkVVI5QVRHUW9KdEM4dURXcDUrTG9HUlltNzVOL3FBZGVSZXBBQ0dUbTd4?=
 =?utf-8?B?WTVBbjlYVmxCV3c0cEMwSnA5R0FzRndvTUJiMVQvSWxpMHV1RGhNL3c1OENm?=
 =?utf-8?B?NU5HK3o3cFpBekZ4eW5kUVRZOXIwS0RLWEFTd0RDdEVwMTFZL1ZQRHRHTXFl?=
 =?utf-8?B?SzFvQkx2cVRjY09pdDhKVHdab0kvRzRBdS9hd2ZpejNGblRqRmp0dE8yQjEv?=
 =?utf-8?B?U0VsY3BUaThJeXQ1bkEzcEs1YVJnNzFnQW53Y09CYi9kSmpUMVdPaXpvM1lS?=
 =?utf-8?B?NTMrcVpYTXdnVS8ybXo2endmN2VmZjluajVQTE5rVXErT241QTc2Z3Z4SnY2?=
 =?utf-8?B?dnpacFo5Z1NTNzJiQUEyOEoxbDhJMHdxcC9FMGMvRGpqdW4xcEFOWjU1TVpz?=
 =?utf-8?B?VGdvRWdoRTVoSVFlQ3JVMzZtb1YwanhHb2FsNURMNzFGeEtncVFnZytWUk53?=
 =?utf-8?B?ODdWdFZsMVNlZUp5WktIUnZzNzA3cmcyTk91L1hST2VPNThvUHplUHcvK0Iw?=
 =?utf-8?B?ZW55cGpOSXgrakpoMTJsUzEySHY5TWZvWjFyc0dBc01pcTlmSUkveW5Gd3g5?=
 =?utf-8?B?eXFFeC8yME9QN0wya3hoNGQzVS8zN1pIaGlxR3RkUFloaForbFV6b3VROWxz?=
 =?utf-8?B?QUxFdEdtVWhhSDd0RnZ6SkQvU3A5WTMrN3dkU0VxZjhwMXBGbkFoU1l0NVNZ?=
 =?utf-8?B?ZkZLaXpSWlNFLzhaWDNMenJHWncvN0R2RG5oRkdTV2Y3QXdlQUd6aDdDRm9W?=
 =?utf-8?B?dFZqcWVZNkJBQ1lDRTJDMjJpUnJLTXV1TnNRbXhXL2tLdmJQeDA1NjZ2UVZ3?=
 =?utf-8?B?WnIzT3lVMFBIcHNDaWZYdGxsZlBpR3d2YWh3ZU1Nd2dTNkx5MTFIN3dLeTFI?=
 =?utf-8?B?d09VR25EMHNVNE8yQzhJSnBFT2Jnempxa3ZUNXZoZEpYTjI4Y1lmd2RFdGpZ?=
 =?utf-8?B?dnlDL1YvSUEzVWpYN1UxWmpIVHdvNEtqRHpYTWNqSWZwekxyVEFBUmF6aWRC?=
 =?utf-8?B?a1hQVFNBL1Q3Ykx1ZTh6c3V1cE1UT2hHeHJZamNudVZqSFhjY25TVTRDUlAz?=
 =?utf-8?B?bnRIaXU5dzdiK2ZTZjRuaGJEMzA0OEZLQ1h5a3Zjb1k1QVN0N2U0MXlWWlA0?=
 =?utf-8?B?R1FpMmJjaXVpNFVVT1lJWGFzZ1FkQmdTK2t5YlBYV2dPUVJvT1FPcTgrcGpF?=
 =?utf-8?B?RDZRczFoTDNkczFId1dXQW9qT2QrWnMvRE5DVG1iWGpXQStEQzhYemtQek0z?=
 =?utf-8?B?dndqS0FiSmVGeXVCUlRTbElwcllpUVZYaU9wU3MyZi9FN2dxclRoQ3o3U3dq?=
 =?utf-8?B?aVhqSElFR0tUTy9zaTFwZkdPSjhwS0VVK0JHMFJjTXhJQ05GQTBwbUlzQnU4?=
 =?utf-8?B?TkkzemNZTUF4UVhUMnNscFVEM0o5dWVWQUx6dExjY21Bdk5nSWZQY1VKUDhX?=
 =?utf-8?B?OWZDR3pQdzFtek1aL1E1SnNUWXV1bkd4b2Q4MlFMQlFBcndERGJiUjBmRDZM?=
 =?utf-8?B?QlRwVWVGRHdGMDI1UWUraXdDaDVTRGR3NkpVenVMU0Y3RVJ3NDdiTTdRMHpJ?=
 =?utf-8?Q?yQNMl1Ok/Y4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEw5VGlIL25GT095bzhZdkdxTU9ka3VnU0xhK1VtajNMY0VhcTg2V1czTThH?=
 =?utf-8?B?QkEvZmczRFNydkNTb3FqSmdvQ2x5a01Iem80clpYUjhSSDVtZ2tDR29USXJp?=
 =?utf-8?B?UWxtNSs4TUpNTThqWHZmcnU0Q2NTWSs1a1JhdUlUL3kzeXJITE1PNmZIWmZl?=
 =?utf-8?B?WFBkUEZVQXVQRDcya2pIUTVUODN2MnViV2R2dlJnNGRtY0RJanY0TGRqZHRM?=
 =?utf-8?B?L2k0VWZGZGpMY3hhVk9pWHFqTkQrbStnMzhEV2RBR3laTjU0dThFRENPaHBm?=
 =?utf-8?B?L0h2UFZaaTJMOW9pSkVuZGFZZ2F5WGpVeExRa1Z1WjY3aFJZcDdvMExlYWN4?=
 =?utf-8?B?ZFpMYmxiVjVVNmtrdmV3dWo1THI0NE50M1FjZUNmK3VZam9reXYrby9KZHE2?=
 =?utf-8?B?akZRRkJneTF1RWRObm1KMGVGbjZ2NGY2WThBSG91blo5VVB5alNORTRjSlhn?=
 =?utf-8?B?UkJCODhOZU0zeklmdWpIWGRIekJKUWxyMFA5Q1N6VWt6dktWWlg1TXQrczdx?=
 =?utf-8?B?MkZkVHpUMlE4bktCZDFnODZyb2ZzWVlnb0ZabVFoYnNrdTlabWhzRjJxVitS?=
 =?utf-8?B?RnlCRTIrcXVTMWVIdjdDZHAvd1A2dEpkUTBGdUt0SjB0SDFrTy9CMzM4T1Jh?=
 =?utf-8?B?czlLY3FoYTdxUWVjNkhpNk9ITjRCbW0wM1hHOHdUWUhhUk1jRDFZeFE2T1hn?=
 =?utf-8?B?OE9SNGNPVzMvbGt5RHpiN3FnK3BWaHlGS2VWOHpmTUFOQmE5eG9FelM3ZWVj?=
 =?utf-8?B?aVFwcmNxSnpwZVNaekxlS3lqY3BlaFdCTVZhVVZIL25VamlJU25VTVZhKzhD?=
 =?utf-8?B?eGEzN3NyakNJVjRUUGtFOWsvaFRpWTRCOGVYMlBoWkNxTmkyelZpUXNrNmp4?=
 =?utf-8?B?aHo5c2wrZGV1ZWxEdzA2Vzh6cGRrTWtVSnRRQW9FQ1I5TEYyR2hKWjQ0d0Rx?=
 =?utf-8?B?QVhYYjhBcCtiZWVpOEtyeUxtQXR2bVFEZnZtWTZ5WDlhcTJHVWlQR0g2Z0s3?=
 =?utf-8?B?NWlJdVFYWXB6eEMxTWMrbm9EZHFhbGo0dHBxbDN1a00vbm43TndXNUNNS1Iw?=
 =?utf-8?B?M2ZPc2lwM3lIUGx4eEIrQlNyN2hZRktONzJSSU4zZWJVbDV1M1RHLy9TQklT?=
 =?utf-8?B?RVNNS2hkVElqUi9BL0RpWkw1bitrU0JMbHU0czdHdEE2a0JoTnJNVER6cERy?=
 =?utf-8?B?dzV3ZCs3cUhkYjJnVmFHd2VuRmgxVk1CcjI4Q2hUY1ZvTElJRERDWTBWTUxa?=
 =?utf-8?B?RkU2WURxTFFvUTI4YVBSaitnbk15WG9Yb2hKSHVSdXVhMlNkK3pPTWxHNWEz?=
 =?utf-8?B?RDlVWWwwNEZjL0g1MFovZTN3eEZHNkRVbEVHaEVaVW13dzhzcUJJTTBHT29J?=
 =?utf-8?B?RUVRbWoyWkdmNEloWG5YV3kySWpiR0wzN2RLeExSQWd0cmlyNXVHMlBvdnpx?=
 =?utf-8?B?SVdqV0t0R1JDVzFiRHNSbkZYV25ZVzdmdnI4bWRlTXRvSzV0YTRqeXZOcFli?=
 =?utf-8?B?ZnZodGl5OXdvcUYvRWlIYmRKaVB5bUJrbnhENVZndTV5RDhLRTJSc2UvRWM3?=
 =?utf-8?B?ZlhBUFIxbThNNXNOOTNZNXRFTGYvVENWQkpzUkxVYkJrN2hmQ28raWUvTHg5?=
 =?utf-8?B?elRIaXkwYnRaRnJKK1ZoSFNFays1aDFweU4rd0pDVElySFNidVphNk5QZWJr?=
 =?utf-8?B?ZGxrN0tmdzJBZTZBRmVucjRjREpqN21TSUtNRm5MR1JYczZqamRDdzVGeXpW?=
 =?utf-8?B?a2dVU1pjMmJVaVpnUHZrWlR1YWxCR000UGkxbnJrT1NnTUN4OXNSWUtwWVZU?=
 =?utf-8?B?d0ZzRW9vNE9xREdTWS85cXlVZmZ5TjNvS1NGcnJRd0srQktZU2IydU81ZGR5?=
 =?utf-8?B?YVMxRUhWTXoxdXlEd0NFa3Y4N05mTDRpQ1Q1dHlyOFlLa0xOYnB4akEvRFY1?=
 =?utf-8?B?c01ORk9XMGtyTFYzZjFNZ0pxOGVveDVlWS9XY3BHQUlJdzEybXUzRGZCeFFZ?=
 =?utf-8?B?SlZWT2t6UkFvcjEvdFRGbytQYmFyOHdXOHQ1NHBGazBrMFR0T0lUUXJXL3BW?=
 =?utf-8?B?M3NCb3htZUE3Tk1mMzN0UEhJYzh6TTlUUzZwRVFtYnUyTVRlQTJ0MjhCN0hZ?=
 =?utf-8?Q?BMfQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b708ad6-8efe-481d-52cb-08dcd1cbde5d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 19:07:52.0602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NsnNLfNAyCp20Csa5uSc6eX8CMN9MDIY7GhznR1svb1CvSh32szNpLU58RGRUyjOGihh/YuBzZd+xVvE8vkhvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10115

Simplify the clock handling logic by using the clk_bulk_*() API.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pwm/pwm-imx27.c | 63 +++++++++++++++++--------------------------------
 1 file changed, 22 insertions(+), 41 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 14706c3bb96cc..ce9208540f1b8 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -80,9 +80,12 @@
 /* PWMPR register value of 0xffff has the same effect as 0xfffe */
 #define MX3_PWMPR_MAX			0xfffe
 
+static const char * const pwm_imx27_clks[] = {"ipg", "per"};
+#define PWM_IMX27_PER			1
+
 struct pwm_imx27_chip {
-	struct clk	*clk_ipg;
-	struct clk	*clk_per;
+	struct clk_bulk_data clks[ARRAY_SIZE(pwm_imx27_clks)];
+	int clks_cnt;
 	void __iomem	*mmio_base;
 
 	/*
@@ -98,29 +101,6 @@ static inline struct pwm_imx27_chip *to_pwm_imx27_chip(struct pwm_chip *chip)
 	return pwmchip_get_drvdata(chip);
 }
 
-static int pwm_imx27_clk_prepare_enable(struct pwm_imx27_chip *imx)
-{
-	int ret;
-
-	ret = clk_prepare_enable(imx->clk_ipg);
-	if (ret)
-		return ret;
-
-	ret = clk_prepare_enable(imx->clk_per);
-	if (ret) {
-		clk_disable_unprepare(imx->clk_ipg);
-		return ret;
-	}
-
-	return 0;
-}
-
-static void pwm_imx27_clk_disable_unprepare(struct pwm_imx27_chip *imx)
-{
-	clk_disable_unprepare(imx->clk_per);
-	clk_disable_unprepare(imx->clk_ipg);
-}
-
 static int pwm_imx27_get_state(struct pwm_chip *chip,
 			       struct pwm_device *pwm, struct pwm_state *state)
 {
@@ -129,7 +109,7 @@ static int pwm_imx27_get_state(struct pwm_chip *chip,
 	u64 tmp;
 	int ret;
 
-	ret = pwm_imx27_clk_prepare_enable(imx);
+	ret = clk_bulk_prepare_enable(imx->clks_cnt, imx->clks);
 	if (ret < 0)
 		return ret;
 
@@ -152,7 +132,7 @@ static int pwm_imx27_get_state(struct pwm_chip *chip,
 	}
 
 	prescaler = MX3_PWMCR_PRESCALER_GET(val);
-	pwm_clk = clk_get_rate(imx->clk_per);
+	pwm_clk = clk_get_rate(imx->clks[PWM_IMX27_PER].clk);
 	val = readl(imx->mmio_base + MX3_PWMPR);
 	period = val >= MX3_PWMPR_MAX ? MX3_PWMPR_MAX : val;
 
@@ -172,7 +152,7 @@ static int pwm_imx27_get_state(struct pwm_chip *chip,
 	tmp = NSEC_PER_SEC * (u64)(val) * prescaler;
 	state->duty_cycle = DIV_ROUND_UP_ULL(tmp, pwm_clk);
 
-	pwm_imx27_clk_disable_unprepare(imx);
+	clk_bulk_disable_unprepare(imx->clks_cnt, imx->clks);
 
 	return 0;
 }
@@ -229,7 +209,7 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	int ret;
 	u32 cr;
 
-	clkrate = clk_get_rate(imx->clk_per);
+	clkrate = clk_get_rate(imx->clks[PWM_IMX27_PER].clk);
 	c = clkrate * state->period;
 
 	do_div(c, NSEC_PER_SEC);
@@ -259,7 +239,7 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (pwm->state.enabled) {
 		pwm_imx27_wait_fifo_slot(chip, pwm);
 	} else {
-		ret = pwm_imx27_clk_prepare_enable(imx);
+		ret = clk_bulk_prepare_enable(imx->clks_cnt, imx->clks);
 		if (ret)
 			return ret;
 
@@ -352,7 +332,7 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	writel(cr, imx->mmio_base + MX3_PWMCR);
 
 	if (!state->enabled)
-		pwm_imx27_clk_disable_unprepare(imx);
+		clk_bulk_disable_unprepare(imx->clks_cnt, imx->clks);
 
 	return 0;
 }
@@ -374,21 +354,22 @@ static int pwm_imx27_probe(struct platform_device *pdev)
 	struct pwm_imx27_chip *imx;
 	int ret;
 	u32 pwmcr;
+	int i;
 
 	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*imx));
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
 	imx = to_pwm_imx27_chip(chip);
 
-	imx->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
-	if (IS_ERR(imx->clk_ipg))
-		return dev_err_probe(&pdev->dev, PTR_ERR(imx->clk_ipg),
-				     "getting ipg clock failed\n");
+	imx->clks_cnt = ARRAY_SIZE(pwm_imx27_clks);
+	for (i = 0; i < imx->clks_cnt; ++i)
+		imx->clks[i].id = pwm_imx27_clks[i];
 
-	imx->clk_per = devm_clk_get(&pdev->dev, "per");
-	if (IS_ERR(imx->clk_per))
-		return dev_err_probe(&pdev->dev, PTR_ERR(imx->clk_per),
-				     "failed to get peripheral clock\n");
+	ret = devm_clk_bulk_get(&pdev->dev, imx->clks_cnt, imx->clks);
+
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "getting clocks failed\n");
 
 	chip->ops = &pwm_imx27_ops;
 
@@ -396,14 +377,14 @@ static int pwm_imx27_probe(struct platform_device *pdev)
 	if (IS_ERR(imx->mmio_base))
 		return PTR_ERR(imx->mmio_base);
 
-	ret = pwm_imx27_clk_prepare_enable(imx);
+	ret = clk_bulk_prepare_enable(imx->clks_cnt, imx->clks);
 	if (ret)
 		return ret;
 
 	/* keep clks on if pwm is running */
 	pwmcr = readl(imx->mmio_base + MX3_PWMCR);
 	if (!(pwmcr & MX3_PWMCR_EN))
-		pwm_imx27_clk_disable_unprepare(imx);
+		clk_bulk_disable_unprepare(imx->clks_cnt, imx->clks);
 
 	return devm_pwmchip_add(&pdev->dev, chip);
 }

-- 
2.34.1


