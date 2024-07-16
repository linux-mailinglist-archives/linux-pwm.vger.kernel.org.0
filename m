Return-Path: <linux-pwm+bounces-2831-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 239D59331E2
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jul 2024 21:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E77E1F24D98
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jul 2024 19:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6971A08DE;
	Tue, 16 Jul 2024 19:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="N9E9gtSZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013021.outbound.protection.outlook.com [52.101.67.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7F51A08AD;
	Tue, 16 Jul 2024 19:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721158139; cv=fail; b=YM3ryDzC2ZcmxFqCO/eMIfr0/4wAyOAf3GdWvKNZAoWWSIaKwRyBnNsIXTjUTVnjfcSPtkr/TX1hWkzqV1J4gmE0OVmpZufq/TrZrH4+Ubw8huJXUr2jsIl0t54lUVTmHK+tl+J8lrnClsU3jefNaooVnnUiwz83LuoVsqLDT9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721158139; c=relaxed/simple;
	bh=thMYuw3K3tfwqHKNcFWNXXaV+D1MTytBhVgxdAZuLig=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=cvxJ6nIBs1+V3ACxRWfKmyXZIZoCJApqHdFwNpzo7cQPl/dOC2UKzMlUp4GjwyiGBZWFW5zcjwfAc1T/eXPQ912/qyz78HKENAqpkLibFzhcL/Iqi3k5gHnnClN2g//ta3WNUb4utBZiYFIV9ojwC/gKVkp7+vuLXHmmSVvnh+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=N9E9gtSZ; arc=fail smtp.client-ip=52.101.67.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XCfoWHzCT6M0ssfNl4yRJsIjciBwztvsYoBL0XqiHyAqvw/LPzR3G7rk8LiGydqK/vBaqbJ092OSxHY9JqikDKAb8QhmajQ+Fz3NHrwGKihks2Ge3afYWBSHCs/TQA508YFANbCzRQd4mAOiMnAAjJ4/gROxxNDbY3y3uTCa5BVtCh/4CQWxcGymuFWydHjPPsRcEpkWImyyS6nv7HgVvTO791yvjc9HSBhroka8ulp3TxDlab7OVZg+OCrv64Jm4a/EImFLWjqfm8zOHmzkpVlRTgXT10CCxURMEzCi7K52RWdNwQTJIvd1VKvSssML8nuQIvNeNHn5rEVvS7e4vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOgSjsyJI4fpqnvbkGA1XIIeG3ehGHzyIXPXA2ivp7w=;
 b=EkB1MoOuZ9qbkoCnmVU3Cd9ugaHIYi7ZAS7dRmZJkvRN1AznUlENQpLt5d3Mp1dYhBEbb7XzCvlwpo6mVbqkB5YI5XiJjCVzsW/POLMQLokuAjN6rfOzDX3VEIcaqxelDdIVwC74OZ8ZsKoazrVJL7B7LHfVYsvz28DNG+MEznakAz1vFKI3zj9SDJL49XG5ANjXpAsmvlgrKC93KcXLrSSbDi+IXner/v+56STbUVV44/xjsB7EM0b7A398UkOWMGnhkw0LR/GusxwL/e6SRWjP+LQdJoiqqP9qxaSMBpNkKeGTNI32kBO1e/kutzXE6f7e6Darb4FUT6xQpOz5tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOgSjsyJI4fpqnvbkGA1XIIeG3ehGHzyIXPXA2ivp7w=;
 b=N9E9gtSZIF0cZGxT8rpjlyf+w20tdqnZ10o6U/GVtw2KJwlNVy45UvHn5ZPbW1v00f9pSzVo1qogiKx9Mi4OlFsOPs0LLjJXOOvPnvWOiE067DI8dJt0+6CBqmDkOAULBfLYua00X0RqERW9Vqiw8/v/5Ul4uhMct5dIlTDlVS4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7325.eurprd04.prod.outlook.com (2603:10a6:800:1af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Tue, 16 Jul
 2024 19:28:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 19:28:53 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 16 Jul 2024 15:28:24 -0400
Subject: [PATCH 1/6] dt-bindings: mfd: Add i2c device adi5585
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-adi-v1-1-79c0122986e7@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721158123; l=2172;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=thMYuw3K3tfwqHKNcFWNXXaV+D1MTytBhVgxdAZuLig=;
 b=Sv+SmKSA8iSBcTYYYn4nHqs5dE4ZNuJZg0rQIHNnDh/nk5qGvWx7lk1WEvps2Zj8YOlbSPOSC
 1S/1aQ/Xs90CHvgoubSb+XoQS7CdO258O6SYCxiX4gCpolfyIM15gxn
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
X-MS-Office365-Filtering-Correlation-Id: b2e23c07-ce36-492d-124e-08dca5cd871d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZXJLcDR3MTdNNCs5SmJDNmF5T1c0emdJQmdQbllrVDd0S25FMzJJUk1TRzll?=
 =?utf-8?B?c092UllybktmN0R6TVFSVzVSNXc1NmloZDE4akxWR0FGUmlObG93RDJ5ajVP?=
 =?utf-8?B?a3d2NXJjQUFMbUM5TzREbFNtS2lmOCtWdUFFcWZkdkFoSnFCaU1hSUdscWtt?=
 =?utf-8?B?VFVaY0JJaWRnelJhbkJFK1ZoTkZkYmNpL21TUm1tS1EvbmpyRUcvbVNXS1Fm?=
 =?utf-8?B?bXpXRDIrcUt5V28vK3E0RjBHckt0QVphWFJmVXFuYzhzcTFFSnJGMVFQM0hz?=
 =?utf-8?B?SlNITFVuUWJERzBBdytUb3JNRUhYaTE3NG9pMVVZSzh3R2VsSlFJK1JobUl2?=
 =?utf-8?B?Y21wNzFaa1V2VE5PMHVldWdMUy8yUEV6aVdaczNFRzZLZW1KR0MwRStsVHpU?=
 =?utf-8?B?cWtKbVdUcktRUmNCdGNtcDVCSEc2UEY4M3ZRNnNZeHlNdXZsOHRRR0doL2dT?=
 =?utf-8?B?UmpIQlY3VnpOL2YvNGxJSFJHYlFnVFJQQ0NkVFFOMnBLcXlxN01hN1V1TUVW?=
 =?utf-8?B?L1MyWlBUREkzL3pZTi9sYlpOMjUvNHBGNzBZeFdaL3BCeWcwLzJMMXVldFhv?=
 =?utf-8?B?NXBiR1EwaU5Ycm5sZ1BIQmdNTmZ4ZzRjeTJBdi8wZ0pkS0RFWi9MQzliL0t5?=
 =?utf-8?B?M1ZKb0pId2Z6YXhRTGpDMC9WUUNuWVc1TlRmU0ljYmFjOUk0K25QY2ZMTk1H?=
 =?utf-8?B?L3UrcUhObjZWMHhsQm03eXF4MlV5eWIrYWpSb01oK2t3SmovZWEvekR2RmJ3?=
 =?utf-8?B?TCtaZ2tWN2ttMFpYZUtYd0J4dnhDa3JzUTlXUVBBMjh0Z2ZxZEU3VE5xaGd0?=
 =?utf-8?B?Y3JtK2VpVXB2Rzg3K0IzNFQ4UzhmeUxXU1JJNTFueU9nWU5zNmhFK2FGQzV1?=
 =?utf-8?B?OG4xbHVhUUtLUGRaL09WaERuMWE0b296NzViRkVGNFlkVGlJY2c3UDBRTS96?=
 =?utf-8?B?c0FCN0RDOGE1dFBmV003bTJWTTJCV0ZHVDkxWEdjU2xWUjFQY2JOU2c0KzBD?=
 =?utf-8?B?M3VldDJGV0FYMjJCdlNhV3ByYUtlM3JEOFQyMHNPcXRJcEZDekZPVGhPVEVN?=
 =?utf-8?B?R3BINDBtbzRocnUvYzIvWkM3VU15RHdCR3BzQ3N0YU9obXQ5QVlkV1JjTHVT?=
 =?utf-8?B?NDQ1Mm85aHlRV3ArRTIyS3JaREE1WGFlWlNWZmZOc2ZoRGtjUjZXbUc5Z3ls?=
 =?utf-8?B?Q1NwWkRlaEtNTEw2QjZXRFRldFBZamhCc05FMnVoaTdjczFFTUxkNTlLZVJy?=
 =?utf-8?B?UDllMTNDUkpiK3BId0FKRkhKUEFXWFBMcWUzOCtPSkxFOUVoTmJSY0NMbThN?=
 =?utf-8?B?SE9xeHErSzYrK3BCNFp5bEMxNkJTRGVaM0NhMnF6bTVJb3pzcDVsaEdZSDNJ?=
 =?utf-8?B?ZU5xK202aGwrNVNrUFMyTmM2Njd6N3BSRHRNSjdIK1c2YVpXdlkwY0V6SHFm?=
 =?utf-8?B?SitsdUdPSkxuNGJIczNTL2lFR3ZVWDdHcWdTTXJvYy9QOWpJVGVuZE41OXMx?=
 =?utf-8?B?RERscjRRNnBtOXMraktPaGdqMS9vb21GZVFDTkE5cE9GbnpoY0x6eGNYSXFm?=
 =?utf-8?B?TDFCb2VKQytNUDQ4YSt4VWQ2eUFBS29zSWxVbmZNb3JSa0hWYWxiY0JHMUto?=
 =?utf-8?B?KzRsT3BXclY1MVNNS0VTVi92ZTltOXJLaUdYWDdtS1RESDJnamtRU2k2ck1Y?=
 =?utf-8?B?emNqQ3R4WHdXRHJVZ2I1azBIdTBvMVRBNGRPMFpnR2lPd253V3dWOGZtaFFC?=
 =?utf-8?B?MENWQStoWXh0LzR5czlzUzVtUU9MNGM3S2ZrTWZXNHNGZ0VvRytHYTJpTk84?=
 =?utf-8?B?QlJhUVB5R01QOWcyZGNKSXpFcUh3Wlh6SmExcXhLU2l0OE1rZnMvOXRqNEpx?=
 =?utf-8?Q?fynNB6z1z8rmq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YU81OWZvMlpKRGNvWTRnQ29QWmE0T2pVMUIyR1doZk51YmRYK3FJTUhaUEh4?=
 =?utf-8?B?YkhVZXdzbTN3OU1TMzlkOG9jUCt5R3RPMEQ0VVZVTzFLMDJFN0lsQm0xdElo?=
 =?utf-8?B?ZTNrVXcyUXRvM1d0ekVNQ3dENG1IR1UwdW0rU0UxYlI2U2ZBcmxtSFRXdmhJ?=
 =?utf-8?B?WUdoT3oyQ0cweldjQm5jWmxIeGd5VW5kTWFVOTM1aDZBYkpzU3pHU0ZZaDVN?=
 =?utf-8?B?NDdWdDJMaHlvSmlwUU1PNGpwRjViZVZrV2tKb0lhMVJMbjFINkZDWEhqSHJK?=
 =?utf-8?B?NFNSTzZ4NjBGVzJQL2Fzb20yVFpwd3JpaGQ3S2x5N3F3RElEYVoxNWc5WFVx?=
 =?utf-8?B?TUVBNUIvamk4L3RwVUdiRWt1SXFwb2J3MG11cjRRWGZjUjJ1dytxYkwwaEpF?=
 =?utf-8?B?NVFFblVWVlRwN0lhSm9IOTVkckhVNzhDeGRDb2FWNzlEYlBvVENpRnY3aktr?=
 =?utf-8?B?U1ljNC9DeWRoMGIwc0d0UHNlV0VTYmVFcEJjN3pYaHJxVGFhVldLMGkvUXdo?=
 =?utf-8?B?VHhEaWM0czVydTVaWUZzSmFJUjI4OXVDQ2RRNUxmemszWEJyeW91UE8xbGhs?=
 =?utf-8?B?RXZ2UGpocXJtS3ZQNktycHpsOHBrazhjYjBScXBkT1lvMURNKzBvZm44Q2Ez?=
 =?utf-8?B?OCt6M1NVQ0VNWUd3QXBoN1NEZUtadWluNG40VGdwVlpaamJTY0pXQkR3VFBJ?=
 =?utf-8?B?QmZFbGovcHlrNnd1N1djZ3NYaTRxTUFDaDJFTXQyM056ZGY1VVdvejBNS3NL?=
 =?utf-8?B?RmlhSWZ0eWRpT3pVVW5LSGQvajhsOU9DdWIwczZ2U2tMdjlMQ1kvdlN5bnVY?=
 =?utf-8?B?VFZFZ0JOcDBLTEIvdXRyalVuSGNiWWtFMFRLR3FYbytDeTZkUmVxQk5jRjVi?=
 =?utf-8?B?VmM5SnR2NTZRYkU4VFdiM0pleUczQThhc3lNZm1KWUpsY2hWSjlIV1NxOE01?=
 =?utf-8?B?dWU1NWpaRUVBUjZMdjV5akxyNmdCcE45NXFEdzgxSzJTZG83Ym5vdEpGZDZM?=
 =?utf-8?B?ZGErTlZWVTlVWGJ4NkRiVkhrTU9oankzMUp2SVNYdjROOU9xb2JYTEtDQnNo?=
 =?utf-8?B?dk1xZ1NRR00xVFk0bGZXRU1FQ0UyV1NpMS8vUFBJaUpFWHZqUXB1dmpKV252?=
 =?utf-8?B?Z3dwUTJmWHArWHFHUWtOL29PR1ZXS0J5MmZhSGttajVVb0VwY2w2bWVORTJO?=
 =?utf-8?B?Yy9rZi9VT2I4MnFvbVZhV1M2ZUJzb3liU3ZFTFNHV3hNTjQ1ZGJqZGdSUXdU?=
 =?utf-8?B?cVF2WDhiN0V2RmpzOUxObUx4bW1lOUhzdXhaSDFJRnhOTVlmWktTSjVqdkhP?=
 =?utf-8?B?aVRwQW9aKzhYd0FmQlNvT0VtV252bVV5MHJTTnNEQnk2Mks0YlBpSnJnV2lV?=
 =?utf-8?B?KzV2MUJ4OXd2bllQVGxOTGNKK29EejhUL1JYY3JKalNtMTRyVE9YSGVKall4?=
 =?utf-8?B?dC9lUkpKMS92N0pLdmFVdDV0MnBsNzdKdkFWMnRWTEFlaGFzL3NyMmhnK3R6?=
 =?utf-8?B?SWRpSVJSSEljakVxTTdWWE1reXBMakczcGhBOThDYXhqR2Z4bFRhdGFpRE9O?=
 =?utf-8?B?WFFQbWxqOFlXTEZoaHNNWXNCRGVIZndKbi9vK2RUd0w3N2dtQmg5cG83RkpX?=
 =?utf-8?B?M3Z4NXNrdGVEcVhlRWd0bGRUZzRDbFB2ekhKN25Ldy9ra3VCdldOWThIaHlQ?=
 =?utf-8?B?bkNnL0NnMUhCcytJRzJQV1pyWERuTXg2YXA3SDd6MXgvUXVUOFdsdWo3L3VM?=
 =?utf-8?B?L3hubmwrOXN2ZzdZM2tyZnFHZ1dnODFuVEV6RlVjM0RnYXVpdkN3N2k1N2U4?=
 =?utf-8?B?VlJwTU1OK3lhbVpSRUl4WjRLL1E5cy9JTWJxbm9jdm5EcmtLY2k0dXIwc2lL?=
 =?utf-8?B?SUVvbldwMWFOSXI0bEpwOTIyNDAvZ1N5UXd1WnhTM2loYlpXMWNCUE40Q1Y1?=
 =?utf-8?B?K3pHQm5hZEhJcnEvcUxEdWJVUUd4NERNbHhXRGx2a1RFQVJFeWpPSkpiTDFE?=
 =?utf-8?B?VVoyVFRRb3VjSHNJUWNjSWdKL1BUUlQ0SXhxaW85WTd3WE5XMTlUMUh1NkFR?=
 =?utf-8?B?bHNjNHdQemcyV2p0Q280OWVJK3Z5NmtnZVI0dGIwa0hYNWluOWlaV0t5U3M0?=
 =?utf-8?Q?q3gHUpxfGeE8Hv31oY+NAb0cp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e23c07-ce36-492d-124e-08dca5cd871d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 19:28:53.4262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0waefRCDRqaPzMGx3U7F0aJFRK6xlT3dgCVQeDBkFrY0oCVG07ApQ5hPmolrpG6eHqgCQwNujJAuTQMDoWqPkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7325

Add adi5585, which provide gpio, pwm and keypad controller.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/mfd/adi,adp5585.yaml       | 83 ++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
new file mode 100644
index 0000000000000..03c4760242ddd
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/adi,adp5585.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ADI adp5585 GPIO, PWM, keypad controller
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+description:
+  adp5585 is a multifunctional device that can provide GPIO, PWM and keypad.
+
+properties:
+  compatible:
+    const: adi,adp5585
+
+  reg:
+    items:
+      description: I2C device address.
+
+  gpio:
+    type: object
+    properties:
+      compatible:
+        const: adp5585-gpio
+
+      gpio-controller: true
+
+      "#gpio-cells":
+        const: 2
+
+    required:
+      - compatible
+      - gpio-controller
+      - "#gpio-cells"
+
+    additionalProperties: false
+
+  pwm:
+    $ref: /schemas/pwm/pwm.yaml
+    properties:
+      compatible:
+        const: adp5585-pwm
+
+      "#pwm-cells":
+        const: 3
+
+    required:
+      - compatible
+      - "#pwm-cells"
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        mfd@34 {
+            compatible = "adi,adp5585";
+            reg = <0x34>;
+
+            gpio {
+                compatible = "adp5585-gpio";
+                gpio-controller;
+                #gpio-cells = <2>;
+            };
+
+            pwm {
+                compatible = "adp5585-pwm";
+                #pwm-cells = <3>;
+            };
+        };
+    };

-- 
2.34.1


