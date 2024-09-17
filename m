Return-Path: <linux-pwm+bounces-3286-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4777C97B455
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Sep 2024 21:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD9551F24A17
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Sep 2024 19:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1205188A11;
	Tue, 17 Sep 2024 19:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PfwhWJuT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE171803E;
	Tue, 17 Sep 2024 19:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726601130; cv=fail; b=hJMFjDry6OWjFiXLLv97283PK50X9lXor09hX3nZJfehKycYtu6De8tf7fiPIbe/ao2APT+iSObYg5UMi5G9OmBUyCmQ46XK4mPM1yqS3orVXT4uv4odEIUMnc4vt76AcsfFvVazY4ti8SwuB9FfAuStKGt5LpxZlDk+k9tuoIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726601130; c=relaxed/simple;
	bh=wSFzGHKe/hgZ8kMG92hZ9jPo//ANSFpE0e3tAwI489c=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=HPE4dH57L5ahWaieHkQgz1LWN3uzE6mNv6dPU/LLLVGbBpHinRcIEHuHJ81dTine+zxBAfFvDDdBoXGzq8DLGlzgKG0G33PzDD+jflZzZTjfcY8UtZtfQosHvZEHwfFOT8opz84BlR6wdulTOq3aLYtPOP/DdJhoUAyw31s6MXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PfwhWJuT; arc=fail smtp.client-ip=40.107.20.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCv5dnFJJvRx/Ozgt/UsH9PLzEuZYw43EnO2bNZn4FR/hzNkh6b0jl2x/Tf5gJ2P1+f6PIEQpYsfvzCi/dJg5s1XasclsHc5SSF+tYNHwCnvly61ADEHFHlFBKhNlnB/KAFI+JM1qsyMRnzkAxYU4z7w9cF2Gvl+7nQtQlI+ZZ0QYCEb/ruX34cQgOV/ZZZxK/YzQoK4HHer5o3btwkgdIoJVp0Tpw9HhRqvBIEzsJWjtxRPv4/A99mZk3sVKhrLHgWne1y951bojA64/sxchIzWhknJvZPumvHTfBX0TRGluDzMkelFLu4ggqWp/K0f6/Jd+DrshhssY2MO+0aOpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Q5RFAb0bcllYmPLhhzRlQ2AC2NOAzUEWBxZ/kYXeaE=;
 b=yRb7nsw/nI5qT3tGWl15yvNJF/0qhwHTA7qYMP26ICw/f0veYnxSzUwkA9oiO5Sm+e6xYCeVu3NDHzCK1Kga9SCX1gijL6Y9CNlefY7mckQN3oGGGRq51sWX/Js3vAasF6gsYWu9jkPZMDmZNU8Lv1JS0pJdFemNHNeITJU3Yq4I1N/KCea209mW8/x0wX4khutzPycSFXZa2r+JeGhoUUxu6EnGTbBCqFAw8DBwhYgzf72EmsNm8PSw/nmdQzHvJoO4NDYFjz7AelHAogATPl2983K0RKTZzgTJYXrKRVmhL2DWu5/0RGUoJleq1kHtIwNs/s6aPjFU4CuIcFpJsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Q5RFAb0bcllYmPLhhzRlQ2AC2NOAzUEWBxZ/kYXeaE=;
 b=PfwhWJuTNL/Kt1nK4F1Xf3lfv/EACJpe7ljgfp58kojNhVyylA9jHLNl9jJoQmwbCz7J6lOq6o//jX0znBB7eHThrXBPNxrX5/G9D4y6MxSz/3sgOheq0LoDMwtOS7Tk1pOZD6j7M4jRy6z5DbGEpvmvvpkYn9465sDOTTR2Z/WfC/Pd4TW1ILhtWx9RhMss8wR3ud/NI24HlX4dAfWJvjQV+bbyfvb79dUZh/CJFCA37T/+jzHXTQwtroa3I6ZkLJBgaeyhS3K9YXwT+X47BmaIk8DSby7URsBK0OcxUXr4+tTWNiBl94RjoBaZnMBA54DQ7Gg9BXLNz7nwFPHZYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7992.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 19:25:25 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 19:25:25 +0000
From: Frank Li <Frank.Li@nxp.com>
To: marex@denx.de
Cc: Frank.Li@nxp.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
	francesco@dolcini.it,
	imx@lists.linux.dev,
	jun.li@nxp.com,
	kernel@pengutronix.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	p.zabel@pengutronix.de,
	pratikmanvar09@gmail.com,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org,
	ukleinek@kernel.org,
	xiaoning.wang@nxp.com
Subject: [PATCH v6 1/1] pwm: imx27: workaround of the pwm output bug when decrease the duty cycle
Date: Tue, 17 Sep 2024 15:25:10 -0400
Message-Id: <20240917192510.3031493-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0048.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7992:EE_
X-MS-Office365-Filtering-Correlation-Id: 1de84318-b28b-4f75-81d7-08dcd74e7aff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0ZBRjNHQTBZaGovemxreE45L2lCc05IVEovQTlmamVBQWpxalUvYXdwRFBH?=
 =?utf-8?B?aTZuUW5ZZmZVTmpEUlpnaTl5WHM5TmYrbGRMbHRhT09BdHZJNS80eXZlNTVT?=
 =?utf-8?B?eGQyQ09pMXFidGEwT2h4b1BhTGpKdS9pNkVmK2NIbnhyTTljdXNpUGFQSC80?=
 =?utf-8?B?SWNQYk5ieHVYT0doT1pXbjBwZm9ETWRySldBTjhYVEZjMjJjOWcvWUxXemt3?=
 =?utf-8?B?aGQzcktHVDJZeXRlcEtKajZoS3d5cm9JUVlvaXkrWFdZV1dMeWM5bmlIbGox?=
 =?utf-8?B?TDc4cWh6TCs1ajd2RDJnbkZtSDlqa0NoUTNqbTNMTlV4eTVIRGpWR0p0c0tJ?=
 =?utf-8?B?SkswSEEyUjhHRDJuT3dtS285VWJRdVFsU1ZRd0MvY1g3cVB0cHNXSUJqUlZU?=
 =?utf-8?B?L05MOEFXMFNMT01SUDJrd1JZRlhiUFNNYUFSYXdqbHVwT0s0MHZPUkFkK01R?=
 =?utf-8?B?N0lCcmdHUlFYdnpjRy9ndUMybU5NR2d1MSt2SkNJc2cvaHZobFJuUHRUSUJU?=
 =?utf-8?B?REQrc2xpbTdnQm5qekFKbFVocHAyMWNyYVJzcUQ5czNaNU9KR1RhMDNEdGhm?=
 =?utf-8?B?NWtXcVlMaHhtUnY2MnBsQ0RuUUlYN1M2dm1zYk1CbEttYkd4Y0ZkS0RReElL?=
 =?utf-8?B?SFBhR3dmSWV1dFM0aEFaY2JaUVU3cjVIUldoRUVOZjN3OE8rd0luMzBVVFdm?=
 =?utf-8?B?RGIxWkR5aGhzcnlUaGt4Z1dTbURIeEsrSVhTWXEwVzZjUGVnd3VHSFd6UGoz?=
 =?utf-8?B?S0E2dUdWOUZ5aXNqMHZ6dUt3dnZFWmdpRFpKQTJ1NGx1RHlUV21CZ1JIZTdH?=
 =?utf-8?B?dXl2WEtkNjZ0SkdHYmgvc2F3YlRGNnBJaysrRnQ2MFg2ZHF1RDk4TjNvMUlW?=
 =?utf-8?B?SHhySWJ3aE5xTVRnSFNHelZGV2pJTlJUOUg0a3F5Q2VtMUpkMXNSQmdkejJK?=
 =?utf-8?B?SlAySDdvRVZqbHk1RlpkM1FGY3pvMnJXMEw5alRZMG1kaklwUk0wVmFJdXJu?=
 =?utf-8?B?T3NhMEo5cko4bjNuL3Q4bUNOY0xWYlU4RitQenI1dVpQZjlEa3VxSElPZldY?=
 =?utf-8?B?bVowOFY2QXMvTGlKempQYTBFdUJnUmVOa1AyMlFCV21FSlgvR0xaREMyampm?=
 =?utf-8?B?bUNjNVMzc1R1clcxcEZmbElnbmsvUU5UV3pGMDk2QWF5cHBzcnpMM2JiS3VY?=
 =?utf-8?B?SkhVQWhHQ1BNSEdIN1ZWOVNTbU5yeDY4QjFZSU9wSVMweU5RT3Y4MFp3YThk?=
 =?utf-8?B?TzBUOXZPUEtjT2xsd1Q1elkxU3FPYmdaVEUrZWlKSmR6OCs2T1pNQkNQUzdz?=
 =?utf-8?B?blZaYytLR2tjaFZpRXJyNy82V0Z4dWtxeGtTQWdoNUNvZlByanJNRjRTc1FZ?=
 =?utf-8?B?c1RJSDVYc2xHMkxrUkd4cmZPdHR3blFmSnJMY1FTV3FRWDh1SlF4U1o3djRw?=
 =?utf-8?B?OFlHNmZINk80bXdoUVVuYmkyaUExb3ZEc1RJNWd1ZXBHMWZhVjJqdWh0Qit4?=
 =?utf-8?B?eWQwaDFIejY3SjRIa0tkelhXcExoWlJSdGxHQzZoSGtGNnlGRENDZkNaM0lT?=
 =?utf-8?B?Zk5KS3pzUDJqTi9BZm81T3A2ZXlKSW11amRmUkpQTkFOUnAyeG9WeGwrWUtS?=
 =?utf-8?B?dDl3MFN2V3Nkb0NOUS9pVVhTUXR0TVVJMFp5Ylh2Sm12bVhUSEszSkYzZis2?=
 =?utf-8?B?b0FrdXNYcnhwQ1BrMzd2R1QwdGlxZ09jZEZEcHRUdEFiaVVPZlpzUXNpYXFO?=
 =?utf-8?B?ekRUMVJYekVhQWJRb2lsOTdvVEpxS3Mra1JKSWxXN3crd3E3NmphZmdCdndB?=
 =?utf-8?B?ZFB1RGJ2Q0ZQT3lSZFlKWGdoclAyRTZXYjcwOXpHZG5YMGx3OFJpd0VSYkRz?=
 =?utf-8?B?RzVsbHJQR090LzIrSmEraGpNSHB0VllJa3RnYVNMaXd0OXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUpySk9MZmVPaTBwd1hxS0RTbGU5L2poeHZzYUJUMjAvTUcwemZscnRXajNM?=
 =?utf-8?B?UjJ2VFp2U1lWdUdMcUxnZXZ5WklONUZOaWVDMzJ5dVJrWjI3RlU2RG1adjJO?=
 =?utf-8?B?czgzZHFPTVVvSkRmN2Noc29MbTRnSThNTDFyWWdPNml3clpEMFhsNEN2QW5O?=
 =?utf-8?B?QnpGYTVuczBBNCt4UXpNZFFCYSs0cEdla3huelVKb1pBMzhMSmcwcE4yVEJN?=
 =?utf-8?B?MHowNkNVVThGUUZ4YjNzRlJ1RllnZWh6aGYzUCtzV3htbXAwbFRxbHNnZnVE?=
 =?utf-8?B?RUhMdzR5SGE0MnFWSkZuWW5xL3EyZGhoRFJ3bFRkZ25Way9ZMmFONEtoS1Vo?=
 =?utf-8?B?eGcvYmFHMnZiUm5PQ3BLdEFWaVN5dHZDM2JORExna3Ezd0RUNG9neEM4SVRE?=
 =?utf-8?B?eWExejUxZSsrQkV4RUtEWlNNRDN0SDBTcWcwQ1lmQzhnVGhQZ0RKczJTNHVB?=
 =?utf-8?B?VThLVHRPZjNNSjk4Y1FIUVp2U25XUnlQdnpCeGM3em5HSnNtUTBVSjR0a2ln?=
 =?utf-8?B?Q201cElQZUpwcTVlZ1JsTGRrTVBGZGZGUW1nbTFDVXZleDcvVlJVck1ZMHpl?=
 =?utf-8?B?YVJESHFSYzJGVFMxeHFubmU0TWF4dUxKaWNKVTNUdGpUYlNXcngraC84TkJm?=
 =?utf-8?B?QzZKMGxncmFRUlFpc1VTbjdxM2xpbi9abXhRekRqNEVOeUdSbTk0SGV2Vlk2?=
 =?utf-8?B?WDFYSDRmWXFUU3JFRS92Y1U0NHFkbVdJem9vb0xYUTJTNGpJUVdMRDgyMWda?=
 =?utf-8?B?NUFCeUZKSGhERmdySVErelkvV0JvVXNlTlo0VG14OWRJM0V2bERMQU9YUXly?=
 =?utf-8?B?dU54VGlpd1pVdGh3RW9iUlRNclNwVG1yODF0ZnRzRGJQcUpvQmZ6UGRSNnpu?=
 =?utf-8?B?emN6bjF3TlIvdkZqSHBsOFA2cjNEcjRFcmZrZTNOTFFaenZCK091bTBNS3lz?=
 =?utf-8?B?eStxTkxmSlV0c2I4RjhqaktoOXBtN09SN3c5cmk3OGgvNWFKSmc3K3YyTk1E?=
 =?utf-8?B?cFlpMHJsN2ZyV3hWNUJkaXgySTJJbDc5TjZmYTdzZGxJNVBFOXdaM0QrQ2FP?=
 =?utf-8?B?eWw3NGppRzFoR0JCSFBZVVNLQ1pXNnBOVVgyM2tuR1FFVFhQZTZrMmpySHFH?=
 =?utf-8?B?dmFnWmc0cjcvSmpESUNLdzYrYUVTVWZIdnFVMXJNS3JoSXFrMTViMFNpeVB2?=
 =?utf-8?B?clNzN0MvS1FUU0Q3VDBmNEdZTG52eXVMOU9GNmF6TjhvKzVXUlV2a1FoYWNG?=
 =?utf-8?B?WEpYbHhMZkdIRDQ2dlZTa1o3b0dhdSs5d3FlMDhuUVFtZzdIMmFIaHVuRGsv?=
 =?utf-8?B?SFljdENpU1NWcGlxcmtkM05RaS9iWVA4aTBxdStma2RjaE5kSk9HWjdLWmUz?=
 =?utf-8?B?d3h4bWszSi8zSlRyWXJoMG5KTlhRczlHZXhJTDJhZ29EcFd6bG5BRmVWYndv?=
 =?utf-8?B?K21VVXFTNEt2ZmtJMitzemFBQjJjZ1ZILysvRUtlMkxvb2Jnb3RYRTlLRllm?=
 =?utf-8?B?aVRvWTVLa1dhOVUrUTFlOXp0clpUejFEVXc2dkRWQlB4STY0YkQxeHJEOGM5?=
 =?utf-8?B?bG91ZnFleDRVVllaT2dRNE50U0dhaW9TZFhlU2F2UGhIKytCVG5aMUVVOE1Y?=
 =?utf-8?B?bis0UzQ0dW9qTG9RVjBJYlo4S3R3Wm01N0dvQWx2dDJBMmF6Z2srOXR4NmtE?=
 =?utf-8?B?MU0zblhOZDFnUkhCMGU1eXBYNkF0MUVTYm9LdEhEcHo0dnBkN21FaXRKa0ZQ?=
 =?utf-8?B?TWlGbVNjWUZIdkFFRzdPbHFGQzFlRUh4V01McHZpOTZkNUIrdjgyaFJkZmN1?=
 =?utf-8?B?WDU3ZUp4NnAvWGQyd3lIbWUwZGEzNXJFekZCbzVXTFlDWm9iRDdYSkVleCt6?=
 =?utf-8?B?cUMvaUFES0tMalpGSEVWbEs0bTJ2MkVYVVVxeGFmNG8wMFNnQXNrRlNqL2dh?=
 =?utf-8?B?V3BSWmxBK3B0WVl4QzZmdldOTXNITUdSWFAzZGpNTnlqK3lkQnpkL3AydHBw?=
 =?utf-8?B?TmV5TVI2cW81NisrTlYwcVJ2bHVpTUsyQzd2YjR0bmloVHZKWGozNnRQUFMx?=
 =?utf-8?B?WHY2L3Z6N0hHUkJYSzhsTTZlRHE4NTNHbWVtSThIN0hkL0NQeU80b0UzdWRW?=
 =?utf-8?Q?VnZStNn9/q12YBLz/cfc0e2P2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de84318-b28b-4f75-81d7-08dcd74e7aff
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 19:25:25.2181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /HyVIY+QV8DJP6JzsRXgWailiONYpNdAyu8AnrMXN++hFq5+tIp94L7UEvE5AQiL8p/4/UdEyX4IDmsMPjeFSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7992

From: Clark Wang <xiaoning.wang@nxp.com>

Implement workaround for ERR051198
(https://www.nxp.com/docs/en/errata/IMX8MN_0N14Y.pdf)

PWM output may not function correctly if the FIFO is empty when a new SAR
value is programmed

Description:
  When the PWM FIFO is empty, a new value programmed to the PWM Sample
  register (PWM_PWMSAR) will be directly applied even if the current timer
  period has not expired. If the new SAMPLE value programmed in the
  PWM_PWMSAR register is less than the previous value, and the PWM counter
  register (PWM_PWMCNR) that contains the current COUNT value is greater
  than the new programmed SAMPLE value, the current period will not flip
  the level. This may result in an output pulse with a duty cycle of 100%.

Workaround:
  Program the current SAMPLE value in the PWM_PWMSAR register before
  updating the new duty cycle to the SAMPLE value in the PWM_PWMSAR
  register. This will ensure that the new SAMPLE value is modified during
  a non-empty FIFO, and can be successfully updated after the period
  expires.

Write the old SAR value before updating the new duty cycle to SAR. This
avoids writing the new value into an empty FIFO.

This only resolves the issue when the PWM period is longer than 2us
(or <500kHz) because write register is not quick enough when PWM period is
very short.

Reproduce steps:
  cd /sys/class/pwm/pwmchip1/pwm0
  echo 2000000000 > period     # It is easy to observe by using long period
  echo 1000000000 > duty_cycle
  echo 1 > enable
  echo  800000000 > duty_cycle # One full high plus will be seen by scope

Fixes: 166091b1894d ("[ARM] MXC: add pwm driver for i.MX SoCs")
Reviewed-by: Jun Li <jun.li@nxp.com>
Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v5 to v6
- KHz to KHz
- sar to SAR
- move comments above if

Change from v4 to v5
- fix typo PMW & If
- using imx->mmio_base + MX3_PWMSAR

Change from v3 to v4
- none, wrong bump version number
Change from v2 to v3
- simple workaround implement.
- add reproduce steps.

Change from v1 to v2
- address comments in https://lore.kernel.org/linux-pwm/20211221095053.uz4qbnhdqziftymw@pengutronix.de/
  About disable/enable pwm instead of disable/enable irq:
  Some pmw periphal may sensitive to period. Disable/enable pwm will
increase period, althouhg it is okay for most case, such as LED backlight
or FAN speed. But some device such servo may require strict period.

- address comments in https://lore.kernel.org/linux-pwm/d72d1ae5-0378-4bac-8b77-0bb69f55accd@gmx.net/
  Using official errata number
  fix typo 'filp'
  add {} for else

I supposed fixed all previous issues, let me know if I missed one.
---
 drivers/pwm/pwm-imx27.c | 67 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 9e2bbf5b4a8ce..bac09d40767b6 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -26,6 +26,7 @@
 #define MX3_PWMSR			0x04    /* PWM Status Register */
 #define MX3_PWMSAR			0x0C    /* PWM Sample Register */
 #define MX3_PWMPR			0x10    /* PWM Period Register */
+#define MX3_PWMCNR			0x14    /* PWM Counter Register */
 
 #define MX3_PWMCR_FWM			GENMASK(27, 26)
 #define MX3_PWMCR_STOPEN		BIT(25)
@@ -223,6 +224,8 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
 	unsigned long long c;
 	unsigned long long clkrate;
+	unsigned long flags;
+	int val;
 	int ret;
 	u32 cr;
 
@@ -263,7 +266,69 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		pwm_imx27_sw_reset(chip);
 	}
 
-	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
+	/*
+	 * This is a limited workaround. When the SAR FIFO is empty, the new
+	 * write value will be directly applied to SAR even the current period
+	 * is not over.
+	 *
+	 *           ─────────────────────┐
+	 * PWM OUTPUT                     │
+	 *                                └─────────────────────────
+	 *
+	 *           ┌──────────────────────────────────────────────┐
+	 * Counter   │       XXXXXXXXXXXXXX                         │
+	 *           └──────────────────────────────────────────────┘
+	 *                   ▲            ▲
+	 *                   │            │
+	 *                 New SAR      Old SAR
+	 *
+	 *           XXXX  Errata happen window
+	 *
+	 * If the new SAR value is less than the old one, and the counter is
+	 * greater than the new SAR value (see above diagram XXXX), the current
+	 * period will not flip the level. This will result in a pulse with a
+	 * duty cycle of 100%.
+	 *
+	 * Check new SAR less than old SAR and current counter is in errata
+	 * windows, write extra old SAR into FIFO and new SAR will effect at
+	 * next period.
+	 *
+	 * Sometime period is quite long, such as over 1 second. If add old SAR
+	 * into FIFO unconditional, new SAR have to wait for next period. It
+	 * may be too long.
+	 *
+	 * Turn off the interrupt to ensure that not IRQ and schedule happen
+	 * during above operations. If any irq and schedule happen, counter
+	 * in PWM will be out of data and take wrong action.
+	 *
+	 * Add a safety margin 1.5us because it needs some time to complete
+	 * IO write.
+	 *
+	 * Use __raw_writel() to minimize the interval between two writes to
+	 * the SAR register to increase the fastest PWM frequency supported.
+	 *
+	 * When the PWM period is longer than 2us(or <500kHz), this workaround
+	 * can solve this problem. No software workaround is available if PWM
+	 * period is shorter than IO write.
+	 */
+	c = clkrate * 1500;
+	do_div(c, NSEC_PER_SEC);
+
+	local_irq_save(flags);
+	val = FIELD_GET(MX3_PWMSR_FIFOAV, readl_relaxed(imx->mmio_base + MX3_PWMSR));
+	if (duty_cycles < imx->duty_cycle && val < MX3_PWMSR_FIFOAV_2WORDS) {
+		val = readl_relaxed(imx->mmio_base + MX3_PWMCNR);
+		/*
+		 * If counter is close to period, controller may roll over when
+		 * next IO write.
+		 */
+		if ((val + c >= duty_cycles && val < imx->duty_cycle) ||
+		    val + c >= period_cycles)
+			writel_relaxed(imx->duty_cycle, imx->mmio_base + MX3_PWMSAR);
+	}
+	writel_relaxed(duty_cycles, imx->mmio_base + MX3_PWMSAR);
+	local_irq_restore(flags);
+
 	writel(period_cycles, imx->mmio_base + MX3_PWMPR);
 
 	/*
-- 
2.34.1


