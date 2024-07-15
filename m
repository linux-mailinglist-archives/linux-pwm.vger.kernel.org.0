Return-Path: <linux-pwm+bounces-2820-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63914931BD8
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 22:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A735282360
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 20:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38AD13C906;
	Mon, 15 Jul 2024 20:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gI68IYMr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011035.outbound.protection.outlook.com [52.101.70.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B360513C3E4;
	Mon, 15 Jul 2024 20:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721075423; cv=fail; b=Jc3TsvtpQ9/l47XYluBsq8MXp1jZx5ofa5sjDiIztbT3a3AHREK2GTGDchMSXHZz5D1wENTEH1MQNaLWEk9gccNtkSMc+myoGBX+2AYHtQ3QbLsebKmMy1vhiJoOPLXk97BdmK2HE5bXvpk8tFZjlRnnnHs5zQLBpU9CybTYIKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721075423; c=relaxed/simple;
	bh=6XAfGPNb7a1ke9LoqZ0qNjul/2KQbvRtHFy0P7YwIUQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FX/IT2L8np2+Bxnuz6yRYgG3dgwT6VcY1YhRLy+DJYcud+Y6cTYcpvppVevAd1H0bF3UMeeg5VzhFlJ6nA5gd4lAwlZOMmx1cB69WiDt1SOcLjd+721e6DFXhg0uXcBrF5tapVZLv6omxbtjRuvSVP0PUmi9gwOLL9Ch/d5Z14Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=gI68IYMr; arc=fail smtp.client-ip=52.101.70.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBwZ0dU0KbaMNduewoph/lroLJBy/tjdJvh2qXTenegmPOWg0vqvx8O6Qqpe1DrD6F1vnoVB8QRn4QvFRorwGMHrcXGM6YJPGIVjvDw0SlXqkNkQervekZKuDIB52vQUJejwR7hCyZRGWNF9F85YKVFb80RxDTXGsWsCXxuVANMfIKPkxdh+KoI+RVdeb8cMShhKgQpbUhhqwPv1d7H2bHNz47Ul3ePKAsFjR7yf7Nyt7Mg80hTiK74E30npBamL4f89p4ESSkZBRGeYYyZ2AGqwKFsJqSPRWE2+NGTiFS6FWMfBrqgYF1uLJBP2mbCM1isZ9x7H9UL6fXDocLI9lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=loNrToPQ8nRsb22SQtIOJcLAmRrMeT5PdyVjK7RVd9w=;
 b=vYsn8O9oYoowPqxDPla4OtOgYGFRD/3+MDACuviXQqIHtki55g5QrS2bP7lUpdyYWKMl+jqrJHB+JsBA29yGJljHcSNX2pRGDIbSPmQzh5Uzn0mj1IGPA003O2Lw8qEWwwZl6R5ST31shca4glkx5tHCjkigGeJ0vO3ZI1VHXX1CvVBXgTHzURviomHh3ar9ge5ZOSSc2E7n7Irj4ikQMjxq4ekNLEnjfLWdiTKZTt4fb8YI6voYiNB16nMX9UnMrE2E0H0rLm5YodDdMeML0nONhT8zFsNcnr9OyY0517D/e4tW/n+4n4f86ArlN3cznvkTfzS8FXwN39kIfOMkkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loNrToPQ8nRsb22SQtIOJcLAmRrMeT5PdyVjK7RVd9w=;
 b=gI68IYMroWvdX6WxXRHQTpmiQ6cXvnLCXWtK49LtJi8XQ6qQ/1YwYMEBcafBIlSw+tBU7RHeRtBEyrxBOK10RpRKljKo5Isjr4o1BwHji3ZUnzOAmD1Npl8FuvEf0vjQQBiq4EnaQhEqk9LspK/9GyV/2Ylwn0kTS2dw1Fl0eoU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9253.eurprd04.prod.outlook.com (2603:10a6:102:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 20:30:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 20:30:20 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 15 Jul 2024 16:29:51 -0400
Subject: [PATCH v2 2/3] pwm: imx27: Add 32k clock for pwm in i.MX8QXP MIPI
 subsystem
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-pwm-v2-2-ff3eece83cbb@nxp.com>
References: <20240715-pwm-v2-0-ff3eece83cbb@nxp.com>
In-Reply-To: <20240715-pwm-v2-0-ff3eece83cbb@nxp.com>
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
 Liu Ying <victor.liu@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721075406; l=2230;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=8yBI5EIYzxRTzuANn9Ot3THiqvcs2WYhNhHWeOps8hY=;
 b=9W8dQzaH/wpxantqymPObtuegzGNviX6HqCOqhUR306/oXEerxfMke0+ZUgzegKSJok5btyQ7
 aEBj8gM518sBtzkqYZJOWfGrA3uRLxVtawfGjgHQQUJD1s08PradoE9
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9253:EE_
X-MS-Office365-Filtering-Correlation-Id: a87b1f8a-8637-4132-d4a1-08dca50cf239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2JTZzJPeXhLRktVVHpsS0hsekkwMy9GZGVBOG9YK2xxTHQ5VDdWV1R0eldY?=
 =?utf-8?B?aHM3Z29ZK1FzalhOVmhzZG00akJsaWVWUkV3VThxcWkwKzZmdFVyamtKTlhB?=
 =?utf-8?B?UCtlVko4Q0VySTNaU043YzhweXVGVnF4aGpnK3VmbDlqTG9OVmt4Nkxsd05T?=
 =?utf-8?B?dUxpOE1wWXBKYURSKzhkMW13cVJMVjhqcS9JM0lwLytiL2QxZWRIL1FkaVA2?=
 =?utf-8?B?NlZKVGkwSzlFYlAxa05xSUx3Y0UwakFESFJNUlJJZHFXYXQvTlhQR2Iyb1Vo?=
 =?utf-8?B?S0l4NmxHeUlGUFJmOXg5WVUvR3kyUjJZaUJGL1ZWUHVFR29tSnFNNDk1MzZP?=
 =?utf-8?B?S25vbjV0ZWZCWGszMXFMNFY0aHllVDZGME9GTi9ieXd1QjRyYVB3Z2lFYkdO?=
 =?utf-8?B?YUM0ZUU1YUtRaElER0dyY0RXYjJyOU1DNm9MQVFGQWlUREtpclN6bzljM0Rs?=
 =?utf-8?B?dndtREFReDBYV2FCb1BCbVV4TVYycUJQZXUxOWk4TU9JVnNIb1puMFNTdlpo?=
 =?utf-8?B?Ly9QeEk0dlNuN3BPNGlkM08wUTFiVzYrdXJHMlVtcU1PTzBaSGxSb1V4cExI?=
 =?utf-8?B?M0h6cnlDaUNlUzNQUldCbkthOGVqcEtTOWIxQ3gzYlZCVjZVcDVHMHo2ZUhF?=
 =?utf-8?B?N21qZyt3QW84KzBrUFFPQmI1TzdTdkE1d1NhdXVyT2l5WFJkb3B1MWxHWVZZ?=
 =?utf-8?B?c25paUNqSDNoaWdrN0s4aytRbFE3NGwvRXZhMm04SlM4azUzMFFPVkdnUjAz?=
 =?utf-8?B?VThLYXF5SG9WdEVnV1ZEeEIzSHhjVFJ1dFVIejlWbGg4Z0VQeUkzK1ZUSmIy?=
 =?utf-8?B?ZUdsa1N3cVdlbnJqRjk5aWpzUzNLbHg5cTR3V2loOW1UL2YxcE9hMzA3RVd4?=
 =?utf-8?B?M1BUbDlsQXBkVUQzMWpZeG9uTjNIWmNDSmNuRGhYSjNpWUpldklXWXlsNmhF?=
 =?utf-8?B?NFlha2VHWk5yZkJPSzd1V2dmSTdYSVVDRHBqVU8zNzFLbjRSOEVYMUF0ZHFN?=
 =?utf-8?B?T2dLRW8rVEQ1a0tYYi9tc1daNU5GeSt2VkovT3VobmY5Yi8wd2hFbldSUVJh?=
 =?utf-8?B?bTF5a0pGUDZEeGJzZ2tzbDZJUll6VDVQRi8wZnpGT1hmeXJmQU1YaDl6bWZU?=
 =?utf-8?B?aURkRWkyTDYzU0VVRkJNaGROMFRuUGtDNUM4SVZ0cWxhRWFwd01PSlBWWTlu?=
 =?utf-8?B?Sms5OEoyRXlzQ0JXUUhlVWpNS3Z2QUlUQnVaenBUQ1M0bjNDbG4xVk9SY2Vy?=
 =?utf-8?B?NW9UK1FoeDdSRTMvNmpYcW84T3FlangzM2tkWjRzZ2k2RXJNd2dxWjJoK2FG?=
 =?utf-8?B?TkVKQjk4OEt5Ujl1ZThvK2hPTDNHb2hRM0lqdGc4MnNFZEE2Qmt4SU1iaHdy?=
 =?utf-8?B?ZlNvTUh1QTlQUkFNWWRzTkRQTkg5ZnpubXpyVU9OOXFMNXEvOTJreVI5REVG?=
 =?utf-8?B?M0lTWExoa0JuMm9SOWtXOWtURy9ad1drTmpKUm5RU1hWTDJGdnZ1WjkxdjAx?=
 =?utf-8?B?bWdMWlVvNWtkZ2UvcGx0Q1FKQnlJcnpRaXdXOVE1UnV4b0s2dE16SDhGekxv?=
 =?utf-8?B?d0s2bXQ5aThzbXA4WEhPZHQyVC9Xb1JRU25FOGs2YWsxcE1TUTdpMXZDNEZW?=
 =?utf-8?B?RGVkK2NBbG1mdVo3djVGeXhXcDk2RWtIcGxEeU9LaXZLL0JDL3hTVWdtZENK?=
 =?utf-8?B?MjJOWURHdzZ3Smw4Ly80VExIWEFyaFZpYzhxSVEvSERSQm94YmhFdTBmMHpp?=
 =?utf-8?B?MjFXOG9ZUFJ2RXpqR01vOU5DSkRYdnlVZmx1UVB0ajZZYUNKbno2VVM1SlFt?=
 =?utf-8?B?c1BJNFlBNDRxNnVEVkVKdGlwVTJLK1RIWjRHOEE1WHNHWktuQlBOS2ordU9r?=
 =?utf-8?B?cU8rREFFWGY2bldPUkNISzdJSFYvTG4xL3ljeUI5d1hpTFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUwwZk9FWC9KWVFlNDM1NHFSNTVVR2tIaWw5Q1RzdmdOUWwwQWxuOTlyazRw?=
 =?utf-8?B?WVhwbUZ5dUkrZWx3ZjJkV1F4cmJIOGViakV0N3gvU1ZQUWZ6UC9IRElCUW85?=
 =?utf-8?B?ZjRRSXBxdTBnSVZUeklManUzK2hzbk1jdTdGRTc3N2FPdGp4UWFES09YWWY5?=
 =?utf-8?B?YTYwV1VUUmNZdDVKZEM1SEJDNjh5K0dCZFA1anZ6Y3lJdStZMG54YlhhTXJ3?=
 =?utf-8?B?SmZ1Q2I5WUN5VFBmVmN0cEFJVjdwd3VNa08wWHAxZGdWeFZNcW1CbDQvc3NL?=
 =?utf-8?B?MFlTaHFEeG1ueFJsQU5vTzRjMHo5OThVUlJ4cGd0WVlHM1J2YTY0M1ZpS1B0?=
 =?utf-8?B?a2U4MmY2VFhVWkZvcTNINmluS1F4dnlPOWF5cTZHYWJ5R2VPYmdKS3kvZXU2?=
 =?utf-8?B?RjloYm9zczZIbUYrV0pVWmJ0am9wS1JwN3hNM1p5STErRVJzcWxnQzl5L2Vh?=
 =?utf-8?B?T2tENi9DODJMWEpUMXUwdXFoNGZHWllRTFVEVjZnNEJhNGZFenJ4ZkoxSmJa?=
 =?utf-8?B?VG5IMEVaZHJVdk1DVFhBOHZJVklweFFyVEQ0VDA5a0phOVh2UUMyZmRtWm5C?=
 =?utf-8?B?TzBWanVUSmxuNk9UUm5DelpLRWk2VU5rRU9Dd3J5WXBwT2Z5bW12VE5PYzZW?=
 =?utf-8?B?a2lZUlBlOUlML3dBWUh2c2VmMHJ2YWdPdThHZVhJMVlKTzk3ZzVqQVQ5K0lD?=
 =?utf-8?B?Qk53VS9ielBLOW9HQ3V4Z21KYkF1MVNVL2xtUzFnLy9VWE5GSXFYYXZ4TFFm?=
 =?utf-8?B?TGVpOTc2MEVGb0lyWUZBR25UbUwxU2JXZ3QxWkhQUEpCM2k0dUorNnFvOWUw?=
 =?utf-8?B?aktNS3B6M2Jac3lYNXFZaTZqbUQ1OTd6WG1BWWp0Tm5YbDFBREkvUEk3aEpj?=
 =?utf-8?B?aXB5SXN5Y3pPSHRhdTFHWWF2THZQT1dEdSsxZ1I5K2VKc0ttbldZQVYxYyto?=
 =?utf-8?B?dUtqbE5TWUl0N0lZM25QbnhxUnNteEF0RHRUaENKTm9sUEZnY1hncVNVVmxZ?=
 =?utf-8?B?a3VwSE9vbGRVclZUdllZNDRhUnBmQ3FJa1NKMy9TNHUvNFgxUGEvdWs3Q2R0?=
 =?utf-8?B?V0NES3l0b0RlWlV6TTJ1Mi9BdEY0UUhHWVR5NTJlbGJ0S1VYY1Rpb3lxOVV0?=
 =?utf-8?B?SjZlZ1k1aWoxb3Y3UG0xYTNwUE1hMXd2UEl4emowK3RwVFRHcHVtUWlpSVAz?=
 =?utf-8?B?STRRS0hyQlB3aktRcTJvV2prMjdwZlhFMzNRZmdEZm40U2xyNUJTNDFXbWt6?=
 =?utf-8?B?VjBVYk9rSGJxUjFraXFndnUxZEhVd3hlZzhqL1VFWUFsNDAxZm40cHJ0dHBl?=
 =?utf-8?B?UHplMmxodUFBMitxMmhSRDBKbnRCTHRnMVBrSjF6cDI5WGxRMnVtT1pscUht?=
 =?utf-8?B?WGdCdy9tK0Z2SzUzRS95TURFbjgzV1duZTFaTzBvQ09lR3dyc2lvQWM4V29B?=
 =?utf-8?B?MkltZkpTWGpPV285NlVCZXJPZjNUdkx0c0RFNHRNdWpTZlhMU3RCUHdncFV1?=
 =?utf-8?B?U3haNUZDUmJ1ajR5QWxrejhZQUZQTzZtSXJFUTdMS2p5OWlyTzFxdHVPUi9m?=
 =?utf-8?B?SllSaWhieXB2MkRNQTRxclVDZjVDUXI1WU0rWDhOYnVPOUl4Vm5uZUpoUlFo?=
 =?utf-8?B?MXlnSml6SENGVE5Jb1pUeVVWZGllcGNET2ZKejdJa2dPWWJ3a1BDVlloV3Y2?=
 =?utf-8?B?VkZUTWR1UHN5aFN6dVlVdFVUdFBrZGN3Z0Z1bnpZUjNzYkRiYVBhMnlEZy94?=
 =?utf-8?B?bHlYWkkzSWhiKzZlenB0cHpoaWJVV1dBTyt6eVBtVEdOQWlTS1VLNGdobXg5?=
 =?utf-8?B?UjVLcnJTR3lhdUdJZnBCb1BnMytDSStIZE15amYwVjR5MEg2OWxlZWlqa3JQ?=
 =?utf-8?B?U3N0QjE4SmpDQUFxRGhZakRyaFdrbHdnL0hLb2k5bDlZMFN3UXpBQkdBbERx?=
 =?utf-8?B?VklMZUhPZE9MNXBTRWNzeW93K2V3ZThDSWI5QmtBVzY1VUxKdFNqMEUyL0hM?=
 =?utf-8?B?QllHd3VtM01zTG1Jdm1QQzd5aWd4RlBDOFJxdXZnTmVuU0dtc2VNNUVtWVdQ?=
 =?utf-8?B?ZVQ1TUNxWmZTSjBGOWZnQzExTXIwMDA2eWJEUlhkTXl0UmdiaEtsMFRueHdi?=
 =?utf-8?Q?q/YE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a87b1f8a-8637-4132-d4a1-08dca50cf239
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 20:30:20.2595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OLdr77y7B1KU35zSzVtSm6Qp2l160YqK/Y1Q71ZzS6PGZlsHImQU/xPEDOyylpWjljHWXTQhtwNkYQeAYmu00Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9253

From: Liu Ying <victor.liu@nxp.com>

PWM in i.MX8QXP MIPI subsystem needs the clock '32k'. Use it if the DTS
provides that.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- remove if check for clk
- use dev_err_probe
- remove int val
---
 drivers/pwm/pwm-imx27.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 9e2bbf5b4a8ce..253afe94c4776 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -15,6 +15,7 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -82,6 +83,7 @@
 struct pwm_imx27_chip {
 	struct clk	*clk_ipg;
 	struct clk	*clk_per;
+	struct clk	*clk_32k;
 	void __iomem	*mmio_base;
 
 	/*
@@ -101,23 +103,32 @@ static int pwm_imx27_clk_prepare_enable(struct pwm_imx27_chip *imx)
 {
 	int ret;
 
+	ret = clk_prepare_enable(imx->clk_32k);
+	if (ret)
+		goto err1;
+
 	ret = clk_prepare_enable(imx->clk_ipg);
 	if (ret)
-		return ret;
+		goto err2;
 
 	ret = clk_prepare_enable(imx->clk_per);
-	if (ret) {
-		clk_disable_unprepare(imx->clk_ipg);
-		return ret;
-	}
+	if (ret)
+		goto err3;
 
 	return 0;
+err3:
+	clk_disable_unprepare(imx->clk_ipg);
+err2:
+	clk_disable_unprepare(imx->clk_32k);
+err1:
+	return ret;
 }
 
 static void pwm_imx27_clk_disable_unprepare(struct pwm_imx27_chip *imx)
 {
 	clk_disable_unprepare(imx->clk_per);
 	clk_disable_unprepare(imx->clk_ipg);
+	clk_disable_unprepare(imx->clk_32k);
 }
 
 static int pwm_imx27_get_state(struct pwm_chip *chip,
@@ -325,6 +336,11 @@ static int pwm_imx27_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(imx->clk_per),
 				     "failed to get peripheral clock\n");
 
+	imx->clk_32k = devm_clk_get_optional(&pdev->dev, "32k");
+	if (IS_ERR(imx->clk_32k))
+		return dev_err_probe(&pdev->dev, PTR_ERR(imx->clk_32k),
+				     "failed to get 32k clock\n");
+
 	chip->ops = &pwm_imx27_ops;
 
 	imx->mmio_base = devm_platform_ioremap_resource(pdev, 0);

-- 
2.34.1


