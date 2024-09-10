Return-Path: <linux-pwm+bounces-3194-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6FB97431E
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Sep 2024 21:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 730C51C263AA
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Sep 2024 19:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BBF1AC448;
	Tue, 10 Sep 2024 19:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="c3UjM5OJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011060.outbound.protection.outlook.com [52.101.65.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275631AC436;
	Tue, 10 Sep 2024 19:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725995281; cv=fail; b=PsenX0JOHAfabkst70bHHWPeqVy2qMOUZu6KXrY1INUeaSo5eSfGvMfmxYwhcFENokX+GUAeKiFdrfAG0JP80w2wCOfg/q0Mrjwb5SuKFWXld54mQCezrvrYv+Uyn3n3FX4m8TsKDPfrpu6ansedPcA1Oj5n/9M1ri6Rezaf86E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725995281; c=relaxed/simple;
	bh=OPJTK5Szo3uv98miP/aIaKW04fTtNNv1xFO57Ma99VM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=oKdFQVfhKLxPmkX11PFH44BKrjHMfBA65gZn6Mz8yW8FZZWNfj9iaZqP8cq9oCD6cp/vNIPTv0xwxe9pzsPZ9+8BS1cPH6hZrm4m+j09oLOaLG+Kfv7hnF/z/ww9Gkla7hamH7FNItljoMyk0QaH8XUE1oD4Wc2Ql9DEFl7pXm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=c3UjM5OJ; arc=fail smtp.client-ip=52.101.65.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6Cl1NEwZSpvSftV4Jq+hjyPDgC0R320BL6DKaO6pkDUcIhXsuUbxOsURcCxGs6jiTZrC4zJEqBQgPPBEuS57MVpbvjkEKXiAV002hQrKmK84Gy99505LHezVfcF650rT+O5HNK78N1VyXqYNoLiXKkIREHa5++yo4/zP8fUoMBjaHlF2GCETVA90mZl53Y+16HJShAExXhHS41iZTiUeSS8dGJd7AJdJTDBxbNJnZqiObuxN94DIdbgUU2Mls79SmtJ53TYMepZPhz8X4kqW4SZDN6IyC72cvduVEgnJvgLnZHVAUGm+Qo2WiwflL4AC6fIHWUrKaO6Ohpare3ONA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpQmdIpW1nEf/t8itYF7d7iwzZIIlNVQvBzSUpk1TFU=;
 b=kESMwTh3vpGTPrT2+3VPRWdwLPMWyhdn/sg7d8PVS1/P7nb1GgUb8emI3PFX6uz4nNjUJ89Hk9goXv/VRr4EpNMUy3NK0XqD1wUWfrOU8Na1AxZPitpA2pIatzl8B5+eLUAPS7j3oNgDkGR2JozDJO41hTOfIIeXEVjauWjzg6AVxSMyqiX3rI2zqQwtpX8GnFZEUxP+5abhJwMrJHp2aAnmb4YZVyaHeMT+f9/KNu6YOVFodzVCx+9OrXioImPOWodKnZMD/5u+vmL6g5/L3CUJexHJ6hwL8KgVzFhwLdIxmTAcqJzdDrzpQayghtGHgLpeCOT+zbMSAYKFcSejLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpQmdIpW1nEf/t8itYF7d7iwzZIIlNVQvBzSUpk1TFU=;
 b=c3UjM5OJNtXG/VTMw6/meZCCVPoNahXHOkJ4UJFAYeB9f8D+pF0dD0CfYyYbgH78Xrr1tg8w7LvRXSE7PPe5fggSMGhjv22B3gNqYOT6EMvP2Nwoi4v/Jpdtn1jz9jZl4DfShv7lhYflmY/T4tC0lJ9IpS+QutUsrzRzxEjF6cko8KZb5s6G4h8c3Ma+ECcaf/1d+1Zryen+WiLndfnEapWViGNX0DA73VNoOs/7Myepj1/uMc/JsMyYDQ/LvReooG+j++YQ/aJDJXYfC7tD/YT85+Gs4pY6TXWcrMQC/6k/j8QfPbbozSWAOm5/UsisUPBcKHfhD4RO4Hr3t2CI1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB10115.eurprd04.prod.outlook.com (2603:10a6:800:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Tue, 10 Sep
 2024 19:07:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 19:07:56 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 10 Sep 2024 15:07:20 -0400
Subject: [PATCH v3 3/3] pwm: imx27: Add optional 32k clock for pwm in
 i.MX8QXP MIPI subsystem
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-pwm-v3-3-fbb047896618@nxp.com>
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
 francesco@dolcini.it, Frank Li <Frank.Li@nxp.com>, 
 Liu Ying <victor.liu@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725995258; l=1677;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=L/XPTHuau3NF7c+XW7u38Kz5DmqTCXnWMscgXXRISiw=;
 b=3OAc+pyLPshIlPRvYlJxzCzQT5iymtxjjZlMgi2MYCbWOLWkSC6fLCzcIH7YuUwpsE8vhjLPw
 Jha9yD8YRN7BkboLQX8tgXsBK2FKzHwr1WjV14yeqo0pMeTWbp5pM/v
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
X-MS-Office365-Filtering-Correlation-Id: 6ae88040-9e20-4c45-b046-08dcd1cbe117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWxvR1JRekhzQkhHSkRmenRGbldNV0M1c2U2MUVhcFhTMEJ3d25MdnBjZ2NJ?=
 =?utf-8?B?ZWlaQ1JuUkVwMUp5U05JcHlZREdqVkZBK243SnZRbUdLREZhdGtSTUQ4UmRy?=
 =?utf-8?B?U2s1Q0p4ZlRadGNxR2MrMTBVakF3K28wQlJOeWZRZk0ycGF6dVhTR2VGdFpF?=
 =?utf-8?B?VzhFN3RCVVhtcFkyc2QxWUlRbVZVVXZEU3JncHgvZ1FzTVRlVkJ1V09pWm9E?=
 =?utf-8?B?NlFib1pDaG5FQTJZWFpHNHpwUVdENmtHaWRoUk1aenRyUnVDSmlXckpKUktG?=
 =?utf-8?B?ZHByYnBsaDVMQ3k5NlZBU0xwUFlJNkVPbjFPSDBNQSs0L0RNV3JxWmZYMWJI?=
 =?utf-8?B?MFVjT2tnTVVFdlJQRW4xdUxPMzJvdzVoQW53TVcrb0RFY1QvOUQ2MG1FV1RC?=
 =?utf-8?B?NUgwdUZuM0tzSVNFbGVWS3dZaWZweGpnTjlXVFlOK3RUNFdja0tHN1JGanI2?=
 =?utf-8?B?RnEzVzJnZmxyN2RrblpLOEErTVJuL2JDZlN0d2kwWEphU0dqRVd5NUlpQ20y?=
 =?utf-8?B?dWgxUFNzT3plRkxtQlRTbGhkOFozTzNBWHJEZmxtV05BSi90UXJwNHRtVWk1?=
 =?utf-8?B?cUdsb256SDg0aVBoS25MTVNyVEQwNmpKUDIybkJFa25RL1E3L3ZqYUlERGZr?=
 =?utf-8?B?aVNFNjZidVAvZ0tHVDhnai8yR2F1NU5Ya1ZvYldSWGQzUWR3eGFEbXJOdkNt?=
 =?utf-8?B?OWlIVmpPWUFRdEVSbW9FclMwakhwQW4wVzFLT1lzZEdwaCthSVZTU090VGpu?=
 =?utf-8?B?eW9uUmRlTlV6Y0N6LzNVN1R5NkZCMEJSb2piRjB6TmJhVXA2Q2Y1UnBtR2Ja?=
 =?utf-8?B?S3djN2VXOXN4SWhrd1pnZitTQU94dGhzL1JRN21pSTFCRkVqL3BaNEZmN2pp?=
 =?utf-8?B?eVhDME5ZaHJ0SHlUUXV2aGNZdlU2T3JIQXNDRVdIWHM2cW9SYWR1MXhNM05J?=
 =?utf-8?B?dnhNd0ljNHN1TzllZFk3aWdITVc1QzlPcVl6ajRiN3RIOUNiWk1PODdNVVAv?=
 =?utf-8?B?OURPVE5YQVFWcDNLTDlpSnlTUzRnZEtrS21vR1o1Z0h6TEYxUUtYTStwN1ox?=
 =?utf-8?B?cDV1YXN2MkMwcG1TQkdwU0YybkxFSjYyM0hJdG9IcWdBZ3RpODZFZXdVamNx?=
 =?utf-8?B?bXRHTThOYUZDSy9TRFRRKzRHcmxVYnVpVzlWcGN2T05LQlJjTnNxV3lidHdv?=
 =?utf-8?B?bUQ0YXcyVy85ZnBaVGw1UmRuUXdRcE01Z0FOY2ZNOFVKWnQ3RFJhR3hPQ0ZG?=
 =?utf-8?B?am0rMzFySWdaSERZZGZwQ2o5WXJ1U1BlL0psNkJCTlI0aU5ha1B1bm9hWC9N?=
 =?utf-8?B?ejZBNlhBMzRMTEVnZEVRa0xTY0NJK0gvaHZkTzhxN29XalJTOUtuUGlBdEE3?=
 =?utf-8?B?bG15dFlFTXgzOWk2VTVVZ244TW9WaUJiRFZHT1V3MUYwM1VtVUZxRHN5VlZ5?=
 =?utf-8?B?K05wZHlOUHdJNGVPWmtkcDZFeGxsbm5VM3R5Vkc4TG1HUmUzUHV4Q2N1SlhG?=
 =?utf-8?B?c21McTZjSDE4ZCs3NTdFeDBHY0RMem8rOHIvSEZQS0psSGlldGpxNFBDT2t1?=
 =?utf-8?B?Y3dxdGNES2orWUtVRWs4NEd3YnI4SW5HS3ZXSlBrd3FxR3R1d1ZRckRIZnZi?=
 =?utf-8?B?V3VjSDNoNzFHYTJFN3lnaDFBMXdjS3h2SEthR0Y2c3hkSUNWd0pLNVFIR1la?=
 =?utf-8?B?WGFvUDBBY2N3eGR1ZEkwZGRQV2IxTzNBaWhQRTRMUXhsaWJGV3BKT2NXV3hO?=
 =?utf-8?B?K3haOVRXM29QeWFiRUxsUExJR0xKK2U4S0k3ck95UVMzNTBOVnBXcUdZdWpZ?=
 =?utf-8?B?MmQvS0hNc3JoTVhuK0dkQ1NwWnY3YVZCNHZmaDdzbVdqaGNpalg5Z05JdmNE?=
 =?utf-8?B?S05LRTVFbHBOVjdoUmoyeXVhczVzS0ExQ2Q3VHlKK2luczQ4L0pHZ2JabWV3?=
 =?utf-8?Q?CZQqt13E1Dc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWFYL2pBTTV2UmU0ZFdlSjJyMzUvZjRXUm9MSlpkVUc3VDNDUThvUUZjM3Va?=
 =?utf-8?B?eUdHeWN5dDlqODhoK0cyRlRaYzNsYmlHR21SbmJiSEVzQTRZTE1XUlVTWGsv?=
 =?utf-8?B?eHplVnVkYUtNQjBaTG5BMWw0bTFDdUtBMmRpaHVTU3F0bUtOQ3piZlI0d2Qx?=
 =?utf-8?B?dDdFZTdKOGNrYUdqZmlQanh2dE9aVnhyTGluRjN0eWJZeXR2RmVYdnNXSGJ0?=
 =?utf-8?B?aElGbWlqZi9YUy95VnM0bXpKQnp1T0lWZWZXVFY4YjNGdDNmTCtUbGR4VEFG?=
 =?utf-8?B?cUhsQUs0ejFXOFJsUkhSaUROLzQ3T1JNS29wbTRhaTBkVldZQit3NVFoU2xW?=
 =?utf-8?B?cHJZNWs4UDVXSk8wNHpydVloZi95bHorOTF4TURaODlpMk9vV3pTM0xNc0sw?=
 =?utf-8?B?aTQyd0MydEUyUzBGalUxa25SQUdVSGlaWmRaaTQ1SzgwUXZZSjVKSXIyVy9w?=
 =?utf-8?B?NDA2c3JCUGN5STUwWFR2ckdTamxqR0Zzc1ZXblNkd0VrM1BPaGt3ZVdwdXk2?=
 =?utf-8?B?RkN1NjB0TnZtazdseTNjbzd5SWloQ0VEbk16WngvRkdDb0FITDJxNGtJeTAv?=
 =?utf-8?B?dHMrd3Nlcm0vb1AwZUFuQjYvbWw0dGxBcTZ2Qmt2enpYSFBaZHVRMHdQSjN1?=
 =?utf-8?B?cWpKUEZRWEZEMk1JblVCZE1GcmVpNE5DNjV4ZzNEZlFJaVFZSFg4SjJyNlpi?=
 =?utf-8?B?SENBUWlDOXlMazVoR0MrWFkwZERnZU9pRXI0cnIwcFo0UWlBZEpUckRIY2dH?=
 =?utf-8?B?S2R0Z29haDZ0T3E3Zi9YcXZWWDVDVUkxdmM5R2VhTkE1cE5OSHB3dDRBcEtn?=
 =?utf-8?B?UzFxRHI4WldnclRTY3Fob3FVWHZxRmk5RzJkZlJhcUY5eGtYT3d1NGp1TFp6?=
 =?utf-8?B?MFVVK3VkR2hwa0ttdVo0ZmF0UVE0VFJSUC9jQm5LVzcrSlF1czNpdDZDdFYx?=
 =?utf-8?B?ZnE5TCtjM2hYaGtpK0V2Q0haazhlLzA0aWx4Nm5XeE5HYjRhS1Ixb2NUNGg0?=
 =?utf-8?B?aFFreGwzd09FVlN0YkprM1RDK1pQMnBVUVBQaGN2Q3FpdytIcysyekQwalBN?=
 =?utf-8?B?allNQWlnTDlPSjlWaWJoU2xzTVFwREZna0JBckhYdWhpR1VybTcvdkRubHk1?=
 =?utf-8?B?Z2FIbDlCSjYxMElUb0RaU0sxOEJKeU5XVDZRQUVHWk5pWkd0NGNjT2M1U1Aw?=
 =?utf-8?B?dU8zcXJPN0Y5UHhqeDArL0dzSDl6MEc2K3RRbDhMNnJEUXV1d290anVTODdX?=
 =?utf-8?B?Vmh5ZTBrRGkyYzlnbnJWaXU0NzE5dEM5cUd6T0hteWt3YmI5SWFmZ0NBS0RN?=
 =?utf-8?B?UldlSjhnemtoZS9lS1ZySUlNaHNzZmIzZUhKcEVXd1dsWW1wU0N4clZNMHJX?=
 =?utf-8?B?dFpOZUpJMDNGNy9lUCtnd0tMNkJQeHNRajVOdTZ5dFNVN1RiQXo5eWJKVnNF?=
 =?utf-8?B?RjExeXFxRU82dHI3c1ZoWTc1ekNZdWJHckt2TStWSUpuZGhlZXZqYkdsSUpX?=
 =?utf-8?B?UEhHZHYrckcwczZZd2JySUppWFpxSUFZWVlwenpqTk9qaVI4YVhrU0pjZnJD?=
 =?utf-8?B?NEpKN2hJVnVsb2FDRnlQUzZxQTN3VmE0Lzc3M2U0TlVsRDR0R0I5K05HU3Zl?=
 =?utf-8?B?emZKeTNxUytsTHdiU05MSFIycnFoUGtrQ2pRZm15b0tnaENDZm93UHdZVDBG?=
 =?utf-8?B?Sm1IRHRuRkhtTTI1UUR2cy9LSnlTZ2R3empJY1lJdVFwQnRBSVZLRnpRVUtC?=
 =?utf-8?B?djdqRDVkdlptNm5LM2ZXUFlnb1A0REhGNWptMzZJYkhnbDJFUEFaN0srTHBG?=
 =?utf-8?B?eEsyQ24zKzFBeXVxdmRTMU9KQndDbFppenk0cm9wWmhrY0VMUk9XUWFJbmZR?=
 =?utf-8?B?dEV4bHFWTGkwdWQwMndxSWhJU1RUZXRTYUhPSE5VaGJHeW0yb1QyQTF5WHVM?=
 =?utf-8?B?SHpsci94SzZMNkxUZVgxVUZJTTBRUnErWmdzN1doZGxremhzVmIrSUJFMndJ?=
 =?utf-8?B?NC9RR3NhaTRwNTY5MUpDSXFWbWtad21lQitNeUZraTNGaHpHcTN4TDVlTnVk?=
 =?utf-8?B?dnBZT1NwSk1yaERVYzd3NEh6d0Y3dmxQQVkyNHk3MWUveG9UVUg1a29rMzVE?=
 =?utf-8?Q?GPlQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae88040-9e20-4c45-b046-08dcd1cbe117
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 19:07:56.5704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XbROQMiS5Nuq1wRXo9P8nNoeqfXBgrLIvMBa36/6lZ3pWoLVBxxuCh4Q64KaCb3LcXYwKsV9fpVTMrcD9VL4fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10115

From: Liu Ying <victor.liu@nxp.com>

PWM in i.MX8QXP MIPI subsystem needs the clock '32k'. Use it if the DTS
provides that.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v3
- use buck clk API

Change from v1 to v2
- remove if check for clk
- use dev_err_probe
- remove int val
---
 drivers/pwm/pwm-imx27.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index ce9208540f1b8..2a9fba6f9d0a8 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -81,10 +81,11 @@
 #define MX3_PWMPR_MAX			0xfffe
 
 static const char * const pwm_imx27_clks[] = {"ipg", "per"};
+static const char * const pwm_imx27_opt_clks[] = {"32k"};
 #define PWM_IMX27_PER			1
 
 struct pwm_imx27_chip {
-	struct clk_bulk_data clks[ARRAY_SIZE(pwm_imx27_clks)];
+	struct clk_bulk_data clks[ARRAY_SIZE(pwm_imx27_clks) + ARRAY_SIZE(pwm_imx27_opt_clks)];
 	int clks_cnt;
 	void __iomem	*mmio_base;
 
@@ -371,6 +372,16 @@ static int pwm_imx27_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, ret,
 				     "getting clocks failed\n");
 
+	for (i = 0; i < ARRAY_SIZE(pwm_imx27_opt_clks); i++)
+		imx->clks[i + imx->clks_cnt].id = pwm_imx27_opt_clks[i];
+
+	ret = devm_clk_bulk_get_optional(&pdev->dev, ARRAY_SIZE(pwm_imx27_opt_clks),
+					 imx->clks + imx->clks_cnt);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "get optional clocks failed\n");
+
+	imx->clks_cnt += ARRAY_SIZE(pwm_imx27_opt_clks);
+
 	chip->ops = &pwm_imx27_ops;
 
 	imx->mmio_base = devm_platform_ioremap_resource(pdev, 0);

-- 
2.34.1


