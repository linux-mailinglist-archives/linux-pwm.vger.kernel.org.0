Return-Path: <linux-pwm+bounces-2836-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 971259331FB
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jul 2024 21:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD4AD1C20C99
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jul 2024 19:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0C31A2FCD;
	Tue, 16 Jul 2024 19:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HnLNJFCJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013014.outbound.protection.outlook.com [52.101.67.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2702F1A2FC3;
	Tue, 16 Jul 2024 19:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721158162; cv=fail; b=nBZZC/gxRRSm+YelnhC69zBLHQlBBkOXot5y+q2YtjRiH3sOpQSN5cnMUfPIImkKtdAdruvvRJS+EBnBPwYgpX5WKZLWjrzbc/UBg+b/uMqZy6XqJNlN9rDLwezKZ5Co3o1ey27nhqmVXYlC1DtBfbu97iEOhTm/2mXdpSBmRx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721158162; c=relaxed/simple;
	bh=fB3KWOR9qVEj3neL/LeJEso6Ca2a7qbn0iJ12IBTwRw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=DKk9EmusRLgI3Sj+IxarbdDnR32CdGbk24ZB0tseqEKCqMskQ8dpJqazfTK8xC6Xsh92LYvQ6kD466zjZea/5sn7D//ubNslcyn4jrWPQ81r8nc9Dukv8t3IgD55s98xz19ZFlGMjZsUMhtP2CNaNbxbJ7pRDxLDZ2Ruymvv0yQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=HnLNJFCJ; arc=fail smtp.client-ip=52.101.67.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=locObgZswZRSSSPMUJxQC/e9y18ai2VPOl5LfH2+igixANry3specEU2iEjY55ybwT+gzg+x/2CNCaOqWyLG+MeqzI3sRovoug/EaulyMuWp5kw1SDjmrePwcAsB9KxGEKlfXPOIRpNafikDD5RqGOFXbZuYRpOyYMnjNF+vC6/LKvV7fpIucnwBuEYewNRzpIb+rDikK7aVzp7inRx+dr10zsq9hXMY+Cvz5i6U6l1HTep1MOh4VWIwUcaZl5OJW4ssT7WrZvO2u4z5mbvxXSFjc2I43f9HNAdRzNLLoeurXCz97buAUj4ciedhXxzMC6Jz4zj3Uaiqh8rCQ8nArw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mV4gpTwO1BX7D0VuhCO5AV4PaS9O/XtK6hGNoMOui3I=;
 b=K65o6FlH/xWPHb698pE3n8Bu7sqGmTL6glkDroZE2FU06ZceoQInIP9h4EHF85ftv+RDVgzXw41K+vMg6/psQWLO8wt79tZwG0mYWCadfv1FbnVvJlPWSXBkjMht4F7ePUuSzB1H8V82DxwJvCiJVcXjRRb2GMa6Eiigu82skdMTwRXICExt4g2/ISv408/OrQi/+t6b2pFywhBYEmhqZQ9xAM13YLlzp6vSop1atyO7TEusa2ylxIteZEJKAvrYFiMSzS+QFsD2Ttue1CgaNDnk7TJOsTMDy73oEngHsjAqJc0Q34ektn/vl8sUJL/C/j7HwRb1enL4AAC+p67PAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mV4gpTwO1BX7D0VuhCO5AV4PaS9O/XtK6hGNoMOui3I=;
 b=HnLNJFCJcI2i9thchmTQRap6zKw48WKHFMjUfPBM1Fbbxnfgr/K8gMav8hmNFDsnZXFfuZpmSzzTkIEBakGbf+GH32+U5B87iUt03jjDRQlgoLK9xI6eOXHWt/3CzOkb0cH/6usNlQqA7ZYY6MVRT4MZkVzPumSLtchuxNpQ+ho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7325.eurprd04.prod.outlook.com (2603:10a6:800:1af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Tue, 16 Jul
 2024 19:29:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 19:29:18 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 16 Jul 2024 15:28:29 -0400
Subject: [PATCH 6/6] arm64: dts: imx95-19x19-evk: add i2c2 and adi,adp5585
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-adi-v1-6-79c0122986e7@nxp.com>
References: <20240716-adi-v1-0-79c0122986e7@nxp.com>
In-Reply-To: <20240716-adi-v1-0-79c0122986e7@nxp.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721158123; l=1437;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=fB3KWOR9qVEj3neL/LeJEso6Ca2a7qbn0iJ12IBTwRw=;
 b=rfaaYgoalQNrbpVG4kUzRkVGTEO/SxNZ7H+ptYb/9MiHnC+OUjdiShJD40VYsFB/qVqpDMbNn
 RCxoZ7GORx8CRuoWdQ5rdc5njzLoMobyWNpYegxkJdV1PjFUZX6T680
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0148.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: d6c16ad0-7883-407c-c9ae-08dca5cd962e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0RJRS9GSTcrNnVtTlhnLzRBRlVFWnhSNmpWcVB0WG54aHRmYnpRUzVLWDI1?=
 =?utf-8?B?UmRXV1Q0VFRaWSszWHpsZVpsR3pMV0ZYQ2pPUjRLbjBiZVpaa0hhS095OW02?=
 =?utf-8?B?SzlQTTVwNXVzZ0ZrQW1aMVdad1phazdBOFBBNmlwSzlCZFRjTWFuNUt5cHgz?=
 =?utf-8?B?bEJzYkEreitTVzFwN1AxRTN1dHJYMkYyTVFQVm9OVkQ4ODA5TSs0VWVpUy91?=
 =?utf-8?B?RWExbkpkZThkeTkxZi9oS3Y3Wm94dTloM2J3SWxMSmdITmEvZ0lrcXMwVUk0?=
 =?utf-8?B?VE1SMUNlQWlIYS9STVZ1NWpKTnlrRHA2V3lES3ZXRkpNZG5ZM2NBbFlML1NG?=
 =?utf-8?B?VWdkek9uQUw0eXhBUzRpeVJqNkNnMnJPdmp1R0l3ZW5ybUZhbTl3RjB2NThj?=
 =?utf-8?B?eWM2RG01RERnNE04amRzME5jb25jdUdCVjhZcnNPMzNodTEzOEZ2OW4xTEJF?=
 =?utf-8?B?elBDcVZEdTZTYjFMUGpmemltUThGbHZIUCs4YXUvY290TFhtdG52eEhnZ3Ez?=
 =?utf-8?B?YkZWZUZZQU9JcGJUWGQ2MXp1eHdNMnFid1pPMjJ3cHdobFdXajdINDZkNnBv?=
 =?utf-8?B?a0Q5R0JvczRidTlLSCsyVW1QS25jTkJHcnJNR0E5SGVFNlFwSG5ZQ0RBSkxS?=
 =?utf-8?B?RlQ5RjFtWmw0N1hGRmxkMitRdGRpNFEyOVdrL3d3bEVCclRKTzZkcjJYRnJD?=
 =?utf-8?B?OU5JUC9BRmRaRDdDVk1CMzBta0V2aHB2K1VxUFczZW8waE9LdkI4MFBVbWtw?=
 =?utf-8?B?Z2JKb0drZ3pXQVVWUFNpU256c0RPZWN1WHRtdkxvQ1BxMUhQYW13L2JBc21K?=
 =?utf-8?B?Zk45c1JSNzJWa0FYL1BvRnhsV3BTekV5SGR1YzRlcHVCc3ZlK1dhWEl2Q2I2?=
 =?utf-8?B?SnpPTEdyK2lpZjhqb0xyQkNvYmhrek4vT212WGFodVpWNnNIRXIrNHh4WkVu?=
 =?utf-8?B?UW1VbWU2NWw4b1hQWVNXTFpobENkNy9wOVJWSnBhbTM4bmNsWXoreS9vSVk1?=
 =?utf-8?B?OWFuZzdzK2EyeklrZkRXSzdnZEdoMFhYalVRNUJVV0doMG5vM0lSa05EbXJ2?=
 =?utf-8?B?VlpaL0w5aXpESmpvV0VCU2UzZ2dVQk9MMlMvSFRCT3VMOVZBemwzRHl2QkZl?=
 =?utf-8?B?UlAyaS9IR1d3YWtIU09VQzN6TFNxblNBdXdrMis2dU9mVjBTL3ByK3RVeU1Q?=
 =?utf-8?B?ZGtRYllQMnUyaEsyb1JwYkk5aTZYU1NmM0FLY0hOU3lmWnVHNHFsS2ZIOGJl?=
 =?utf-8?B?MHpaTkkwSkhSWWNZb2x5MGhwZnFNTmp2UjRsZFhPWW5TdzY5ekVQcHZKNkpM?=
 =?utf-8?B?Q0gybDJyZUpuZ2ZYbGxhS3o5Si9CU01ibnRqcFdDMWxkSGFnWk1UbTNZYWlC?=
 =?utf-8?B?SktMazNsakFqdTNNanRjYVZQQ1FIbHA0cWxMQmxUQmhOU3JrUU5mM1RiM3M3?=
 =?utf-8?B?UGpacVUyZU9mbEs4L2QvRWt0bVNCQzNNNERIY2RzbnBJczJVcE9JSFhzejRs?=
 =?utf-8?B?MDBER2JOZ0xpWkcvOEdlZmxFcTdOZnpybUd4VnJZV05wN2NHOGIyZENxRUF2?=
 =?utf-8?B?MGJxNXpXQmxlYm5YaThzeUJzZUdWdnd4bXZqanZGdnBmSVNBdTZRQS9Scmwz?=
 =?utf-8?B?TXMvSVlpRjRnMDRLNkZmNEQycXJVS2JZK3FIb3lXVmlzb3BiZlBqT01GNEVL?=
 =?utf-8?B?aWh6c2w2eEk4UjdQcExVQVVZeXNEbDc3dExrMWFHOVpjZU5OVVFmdytDZFFv?=
 =?utf-8?B?Y3Joc1RNZFlVTlh5NkcrdjBJOFdtUG1yaXY0ZXMzdGdxWWdyRmxHUUJxZkUz?=
 =?utf-8?B?c1JUVGZpYk1ldVhMMncvQmRWZEROY3BhdVY4MExob2hPVnU4S3hHTCtzQVBZ?=
 =?utf-8?B?SlBpV01HMGpDc1FNb0FMQnlnRlVJTUNrM056djZYTU5qb3BOcEs2WG1TeS9p?=
 =?utf-8?Q?vwAQ93yuyAA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlA2Rno4bFdsL0pQMWhwT2JMVzJOWDFjMnFMbWhMNENqaVR0Wm9MMEJiUXFK?=
 =?utf-8?B?YXdQaXZnWmlxZjdQRFZVaThuRloxNCtCa3FkeldKcjhuUXZQMEhBRWd4WFRu?=
 =?utf-8?B?a1RXS0twUmNnQmFyZndZTnlpMEJndWFua0MrekUzblMrNXY0QWs2d21YU0Mr?=
 =?utf-8?B?VTZaTmRsK2U1ZFYyT1hmVlJEMEw5WG85V2xGWkhySzBvcXdjMHoxZGhnWTVs?=
 =?utf-8?B?MW16djFzOHBsQy9mcnUvZXNJbHo0WlRaWk9vYVZTOTc3MkowN0JPbHE0VDQ2?=
 =?utf-8?B?dVdnWW9Od3RyUnVTUDlnMG5RUlNuUHh6TmUycHNnT1Y4QzNDd0VCeE01Qkcx?=
 =?utf-8?B?T2xmMm0yeU96RkkvUjFESVZleHNSVHhISHNwVEtZd0d1SmxFcWtRdUIwd25R?=
 =?utf-8?B?V1ZJa2xOamwzcDRmcVpCeEpBaVJsTUwxOTAzU0VYNi9ZNllaU0tETG8rV21x?=
 =?utf-8?B?aVRUb2dvaUVlSWRTdDNkRjEyTnpDM2FDcFQyZTJaUUJuaVhKNUp4d0tidUtZ?=
 =?utf-8?B?dlFBZ05nejlweEpOdWNheXNtUXFsY3NFS1J1bnIxN2JBK3ZDRjdZSHFBMytq?=
 =?utf-8?B?YTRHNWZpUVRSaFBGOSt6cmlaRksyNFozMVpKNE9IVFBzdkdPL1g5VWhvTUNX?=
 =?utf-8?B?aVJxandxQ01ZYVJ1cURHZjhJVmZuWXl5UUpMTHRDWHJDWFhSWjUzT1Bucmdr?=
 =?utf-8?B?dFdGbzNJNWZMRnMwZnhvKzBNUm9BZVhzMzU1S2xJRGNFaG9qQTJLSTdCamIv?=
 =?utf-8?B?T0lRd2lZYkNRQ1MxbnVqWVhuRnNCRjM4eGVmQ3Z4S3NDa0oreVdsNGVxR05O?=
 =?utf-8?B?aTQvbWdTaTdYdEt0K1l6QjkvZTFIVVJKbk5iRTJhOEhVQmNTdDZWbnpTb0to?=
 =?utf-8?B?ZzdrVjlhVUdwUEtzYmtPUlprSDlhd0M0QzV2d2dVS1hjU0VLT09idFVPQ3FJ?=
 =?utf-8?B?a3BjMnNjdWFrakx0cDI3R09SSTBEcTRiaVNOek1XZHlGaUQyWHBQSUZjUFdF?=
 =?utf-8?B?Z2Fxb2ozeTlBOWdmOFZueHVpWlI1bmRxUUE3WGVlOVhtK2RvNklBVnJmTjFr?=
 =?utf-8?B?cjBwQzN3ZEduTjNPNUNra2FScmZOb3QyMmZYQStUUElnLzBRV2JYdXFvT29p?=
 =?utf-8?B?RllwVHEyWStUdEZhMHRIVG5wcDNPRU1UcEIwT0k5U1FTMUZHMnk2YW5kQ2Jt?=
 =?utf-8?B?czBxMEtIT2xheGRzUHRSeDdnNThyZTZrYTdMbjVIeXpEQkVHNnVGVmdvOFlY?=
 =?utf-8?B?NEdteDlWaTdjWTd6SXFDVTVTemZzejhGQzhXc3pDa3FQS2Uvd0VoS1JOSHBt?=
 =?utf-8?B?Nm9od3d4SlQ1ZkEwUjhSV3VpQ2Y3SW1WYzJNSjVwdnJlUkJDQUhqaEIxazdI?=
 =?utf-8?B?eUYrZHVLSDdrcDN0QWlrMEZDWHZ1NVhpRWZXRzlacEtKZmo0OWx1VjhZeG5j?=
 =?utf-8?B?aE5GVVY0aHB6S2MrQWVQQVYzeHAvcGp1ZzdjcjhXWDFpNzhtTEtCcUJqTFY4?=
 =?utf-8?B?Y2tHMHZEazFja2Jmd3ZMZnI4VkNTVTdkczZpMjdMbnVoYUZuRzlPZXF0SjZ1?=
 =?utf-8?B?OXZQNEhpdTg5RW0vanJaMmRqaEpiN1QrUk4wWmhUdjZ6cE1NYU9UZlI5M3lw?=
 =?utf-8?B?UUNCcWFVUkduc1VZOEFxdXVlOFBIalJlMHF1QnpnQldkUnJ5N0RUTVBJTGlm?=
 =?utf-8?B?SnB3b1J4U0VXa1VWWDBUQVMrcnA1SzNGdmFqL3dvNmcySGpUZ05iUzlLMGdM?=
 =?utf-8?B?V09PK0lzbGFyTDUxTkR2eURzZWE1UU5icmdCOURjOUxzeEFvWjFRdWVQNFVL?=
 =?utf-8?B?ZVdycTNHR0NURzV2SFBkTElOd2JIYi9Bd3hkYUszQllwY1NOa3hwZS9mTi9M?=
 =?utf-8?B?cnM0Z3YwNXJEODJWNnF0RHBFdWFsNk1KbEMxdiszR0VaYTRXVlNVbDBJZ0Rj?=
 =?utf-8?B?bENvMGJzc3puWTUwbDBnQ2pYRk9sdnFKZXd6azM4QzNoeVpESWxEQmdORXlJ?=
 =?utf-8?B?ZzcyYjl3YWU0bHY5VDNTd1dSZWlJeWNsQldmMGZib0tBZTd2UEJYZ0lTV0dx?=
 =?utf-8?B?Mjk3WThBTUw2TEhZeGRwcVBCRWNzQlFpN3p0Q1RCL0orWEkyTjUwZzFnMi8r?=
 =?utf-8?Q?Zb8w=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c16ad0-7883-407c-c9ae-08dca5cd962e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 19:29:18.7115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U43SIJB8SeFIl1zzIf+L1GByPGj6WGUOW4ithFD1m3g9+tCokRhflIo5MVopUUzdgHTk09UILaeqIhakEMn3kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7325

Add adi,adp5585 gpio and pwm for imx95-19x19-evk board.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 30 +++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index d14a54ab4fd47..8c52fec79535f 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -81,6 +81,29 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
 	};
 };
 
+&lpi2c2 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpi2c2>;
+	status = "okay";
+
+	adp5585: mfd@34 {
+		compatible = "adi,adp5585";
+		reg = <0x34>;
+
+		adp5585gpio: gpio-adp5585 {
+			compatible = "adp5585-gpio";
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		adp5585pwm: pwm-adp5585 {
+			compatible = "adp5585-pwm";
+			#pwm-cells = <3>;
+		};
+	};
+};
+
 &lpi2c7 {
 	clock-frequency = <1000000>;
 	pinctrl-names = "default";
@@ -159,6 +182,13 @@ &wdog3 {
 };
 
 &scmi_iomuxc {
+	pinctrl_lpi2c2: lpi2c2grp {
+		fsl,pins = <
+			IMX95_PAD_I2C2_SCL__AONMIX_TOP_LPI2C2_SCL	0x40000b9e
+			IMX95_PAD_I2C2_SDA__AONMIX_TOP_LPI2C2_SDA	0x40000b9e
+		>;
+	};
+
 	pinctrl_i2c7_pcal6524: i2c7pcal6524grp {
 		fsl,pins = <
 			IMX95_PAD_GPIO_IO36__GPIO5_IO_BIT16			0x31e

-- 
2.34.1


