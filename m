Return-Path: <linux-pwm+bounces-3172-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D04059722E7
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Sep 2024 21:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FFD31F213DB
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Sep 2024 19:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C1D189BBA;
	Mon,  9 Sep 2024 19:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IODStxZe"
X-Original-To: linux-pwm@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2054.outbound.protection.outlook.com [40.107.21.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7432D1CAA6;
	Mon,  9 Sep 2024 19:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725910760; cv=fail; b=XkQNfh8TP6eLTUH7kC5MEliYpaHdLvPBHgeI0VehnwFJ0J/L7nf0nKSk+fCPzrNKc1xw8E38pieExHvBAH8qsg8jPlbDmQQBP5EFE0Xnjz+Ag0wSHfcwL7R5xU5aalMUmQ6teFUmzG/8hezHd3/SsYyOu/UQQgEKzaXsnn1WqQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725910760; c=relaxed/simple;
	bh=T7KhXOnsnIIPa+2JhFaYwg9cTmeugUkC5FVAAlQ8UBw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=oYLESeXm8HRTwd4eXuFL2IhjA2Ah37OeiFiM700kxoKbTlfICuMBo9fryOoCpbuK3kjRd16WfZ2qzXnoxIYIgw/Qn5hWEJsDM/9Aqlbjm7vyjsAomRq3q+JFZePamHgKvscCb6oiemZwdWvH62ASzfk2COcprSBzmxfu2f6aTCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IODStxZe; arc=fail smtp.client-ip=40.107.21.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zx7WihHtITJKF+ZFUxLwDXZRdFh+H9DJuAnUQ5VlxgpgIDRuWrXh3BKepxZd2cRbVFxWFYy0bClDFdX+nLiuyGQS4nlYgdM1En01Z9SR3rHoCeKG6dnVw/szaXI1ZfQzX6S9jS+XiVw8lfRqyj1iXtZ/chrg85nCB+m/K33KGzilhmOFtNkfprNgh+ITmMmfasjhx4pxomCj7d88bCGYmV+znqAVswBnJ/QQub2v/ersJD2cgjUT0CRrmFDGDz6Sy4IGczmTF1nYKdM9kINut9ktlytbMnXAdzb9iFeIoK2tk0JDRuIhlVQetvXL938e0Z9u0TNzqpbXq325zWI62A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpzX3vOA3Sby+Lgs9FL3tcTpRtSOpfwbLu0BG+gKV3Y=;
 b=S2FnLafKkhPbVHkPm3XEMlDStobriRVGuZ02CzSOifTRouil9dOGuw0377BOMfqhV6P1jxD+CaFgKSeP2lDAPG2ZSCOLrNryVqp+HFDcb7PKnfuKsA2CheW72ahao9C96p9yHOFyf7L6MCqnMh2rlHWhK3J+xL7mb3STrqhX/PuyWzg0e+AiktgQPTA3drq601aQh9WOBVk99GxB2fp8qa8VaOd9N8xW9oXKZF9LVx84EUZrJQIClY4RjSNXZiHAJOgBkGoDI9Bi8FY+Nog67OuNgv9Wuif4g559KzPwkgRK9ox4vIYZdI/eobAnIvWIcW6p6Q6xVazvKAx04vdY2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpzX3vOA3Sby+Lgs9FL3tcTpRtSOpfwbLu0BG+gKV3Y=;
 b=IODStxZekceuOth90FTu5JoCmweyT7BRcUrd8RHkmikXIs9WAhhQ+B3uCL2XGv6wZ5XtOtRaSTI7ontSBgLsOKmNeTtZErc0eLwpO3NKZibeNYYaJsje61JRUjoCyuWmSHxvVOMSbSzGBXZoXKYtWeB6PsTcQ3z+nPnh8FZOxq6OoqGoIl4/05SzfvOCcN+TTLJ7tA649i9tInpDuI+efRkr7B0FzXhLEI2HbIn1zqsilLoQvB9oaZxtNH8Las15SFcjmioGvzesrA8vdLQnpyHqqF3u1M3pQFUNnxV6pfM+lbJR3KbMneOdo02uMZsH2j3zHsKvQ57c8UQ325twaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB7716.eurprd04.prod.outlook.com (2603:10a6:20b:280::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 9 Sep
 2024 19:39:14 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 19:39:13 +0000
From: Frank Li <Frank.Li@nxp.com>
To: marex@denx.de
Cc: Frank.li@nxp.com,
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
Subject: [PATCH v4 1/1] pwm: imx27: workaround of the pwm output bug when decrease the duty cycle
Date: Mon,  9 Sep 2024 15:38:55 -0400
Message-Id: <20240909193855.2394830-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0136.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: 108a1fbc-4e0a-4ffa-27cc-08dcd1071588
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3Bvd0Vyd2EwL0JrVG9lVGgraHgxNmZxeVZ0cEZVMFdyKzVYL2pMcHlKdTNI?=
 =?utf-8?B?VjZCT0szeEpaZTVxdW91L2Z4WFc4d2xMcE1LMDJvdlpVQ3k2WGlvR1lZZXEw?=
 =?utf-8?B?enhDYW1JU0o0Zkp3blllWGMzUnF5emx2SGd1MVI4dmdEVEJ5UklEUHBYbUlC?=
 =?utf-8?B?emh0dHgrK01KZHh2aFk5QURsVXBUNkV0UGcxbXFFajM4SFpQMVFNdERWd3gz?=
 =?utf-8?B?dDdidUxhakVhS1Y1L3ViL2Z4czB5VlpyWEdQUC9vQjlDbVVVaDFBTU9zTHpE?=
 =?utf-8?B?bTJqZEFQWmhBSWRqNldTRWdGQVV5VmVYbVMwNXYydUZXT1JMS0hiNkI2dVBY?=
 =?utf-8?B?azRRcTk4QlVUb005UU1ITFRnQ051OTdCaG1OT3VOQjNpZ1hiWXZ2clluQTJj?=
 =?utf-8?B?blI1MEswVkNWMExVRHh6ZVd2UUJpeXNnZHRvOUhVMHV2T0lTVkx1ZmlKRFl0?=
 =?utf-8?B?OWpvcUhCZUIxdmYxVUw4dkt2L1NCU3FUV2NhVFJHc09BTnYvbVcwaUVnRDdS?=
 =?utf-8?B?SkY2WWFtcWhnQTFybzBwdmF3dHg1UEgyeHJHU2FSRzJ1Zng4dXZiUjRIcEZm?=
 =?utf-8?B?SWNCTk1OVGVENjc2eEp3bWNPbXMrQTczbVlVVDVPVDlEK1BuT210VlRtYTBm?=
 =?utf-8?B?QmlDa1hqRWZtVVVxRjkrck9wODFlNHpuNitkaEJuYXVJYUJYTHBIRTRvbStI?=
 =?utf-8?B?UG0wWVA5dEZFR0FuMUFmQXJQOGs5S2V6cllGQmkzVWw1RS9zc3dQZ1BDT2Mw?=
 =?utf-8?B?MDJ2L3BCcThVdnpHL0htZXJXa0llYWVweGN2bzZVVURlRm81YXVFTytiM2xx?=
 =?utf-8?B?M3hZaHF0UXVxc3VHRy9zdUhCT3hreXVsT0d0ekJoZUw0NEhaWU1FTSs4MFR6?=
 =?utf-8?B?Q2J2MFczY3F0OCsyVEZScTRqenRrUDNFYU9FUU05MVhLVGh6d0svcTdBK3NW?=
 =?utf-8?B?eE93OCttY3pFN3ZVNVV5QjhtdXdsWk9HQjk2TXprdmtqUWNlcThsTGtReHE3?=
 =?utf-8?B?WEdpTURuM242bERram1kd0xVNGY3T1NmNnJoUGFDZFk1QWxHaEJHbmlZY0xh?=
 =?utf-8?B?UXhObTZsZkJFdkYzR2J3TDZFN0w0UEdwelVTdFFTdjZ0WnJMSWxSRHFvRjBj?=
 =?utf-8?B?VTVpbWZCemN4RXVTL2EwY2s0bUlQVkVKbFZVOExPTEhPUUZyWEREVEpqbHNY?=
 =?utf-8?B?VWxvbEhJcFhQSUM1WXIrZWQxeUsxZWhLVmxqMWlpZkVBUUQvNnpoeEx5bFVx?=
 =?utf-8?B?K1FhRlJKemE0bEEya0EreXBWd3R2WkIxeWQzSmF0cWJ4amRVTXpmNU94dVpL?=
 =?utf-8?B?NVRKQVJZWHVlR09iRXoySzJhWitBS0pRRjFOQjFqb1ZBMXpMVFNwZ1RBMzNX?=
 =?utf-8?B?cHorKzNyYVBzU1VvUzA2TnJsNHFKQlhZWVRENG4rNnkwNW9NYnB2eG84VlAv?=
 =?utf-8?B?U1U0ZkpHUUU2RWVxMHhYVXBOQjVGSXd4Zm5hV1ZKTHU5Y1V4aDFXZVJjUGhh?=
 =?utf-8?B?NThRcFlsVVAzT2xWcTZnaHNXK0lPZm1kUDg0bXViUjVVUVVZekJ5MWNoWDdu?=
 =?utf-8?B?R3VlOGxoMlo3TmtYUEJ2OWhFc2JEY2M4MUNueTBrWksrZkJNNG9nTGFRY0k3?=
 =?utf-8?B?ZjdteFJ2Nm5ETHJ6TU1DeTQ1clFTbEVheUxFQVVvdG9pdVBSb0RaK3F4N1FU?=
 =?utf-8?B?bVRQSzUxOFFKaUVubGtvWEdkRkpoU3kzVnVRNzdGVmVsTTExbVpjQ2xrREE1?=
 =?utf-8?B?TlZPck9IcVF6VmY1UDJkeHpiYU8zNWVaTytGTXJDV0k4L2NDa09FWVBUN3Vq?=
 =?utf-8?B?Mm41UzdNVVBrbFVvY2pTOHNyV3Mwa0FuS2xoZ3JyWEVxeng1Yk5rVE5BWjVE?=
 =?utf-8?B?dkxySzNWNVo2cCtGVVhjZ3Y3V1pQSTNlcGkxUTBBbm42d1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlBVVC83WHdvOVBreG1XZEZzVldHMzRYd0xQcTZTeGVpaE00cXlkbVRpQVQ1?=
 =?utf-8?B?TkpucmtUeXQyYmpRVW0ybDczNmtyTzZKNUVleXMzYVZKWEdOZGN4R2ljdzNl?=
 =?utf-8?B?Q1pUZ0ZuczRhWjAyY3NvRkZsenFWYTNDSjFST3NOaW54T09vYThwdlNDNkxt?=
 =?utf-8?B?bmlteWc1M2Qvbm8xS21LZ0VGMEdHeUQwd0o0eXhCR25PUjVnUU5oWnVFUHY4?=
 =?utf-8?B?cEprZWZKVVJMejFyUkhTS3ZILzdWYmRVKzNRSTlLeVlSWTFjaEtHakpQM1Ay?=
 =?utf-8?B?MXpEc0NVNUtzTCtxYm1GV0RHQ2NLYWtCSVc4RWk3SytQM1BPWU9yM0ZzVVht?=
 =?utf-8?B?dmtiTytGUmc1L21pNmloRWRacFRuUEVFVUJidmtuTTJvdUZDcVJxeXRmays2?=
 =?utf-8?B?elZXY010M0ZXcG85UTNiM0hCVXNORUgyTTNEZVVSSENqL08rZTN4WlZjQkpT?=
 =?utf-8?B?cHNHQnJVOWkvUGFibzRndzE1Nk1wRHBOT1U3amZ3VEFjZXkrODgwK0FjRFBE?=
 =?utf-8?B?QkVJaHllS0ExYzBKVDBSSmthdjErWUk4RTFDN0xOWjdYdkczNGZ1OTlhQ0kv?=
 =?utf-8?B?RENhYWZuRXVWa0lwelVhTy9XSVhSM3cxWVBIQXJGQVlsK3o1amV4WXhkZ0s3?=
 =?utf-8?B?NTZQVnJYOE1pZWRtWTZzOE0vd1I5ei9KN1V2VjBzWWJibU8wRjN5Z2hGNHNY?=
 =?utf-8?B?K2hzeS9NQ2Z3ZVd6MGlKV0RwMmo3WU1jNFFsSVN2TEs5RWs3RGQrRWRlTlR2?=
 =?utf-8?B?aGwvYXplNWRBdmw5OUZORDJaTU1iUFdwVnRPeHpJTWQwVGtXUWpQcTBsTnFx?=
 =?utf-8?B?R1FmQWNETEFwN296UldNTW9FcStyZmh1Z2EzSTNqZWhIWjR0dnhoajliWmlW?=
 =?utf-8?B?bjVJRStIUjNGMGliTHRwd0loZnNXMSs2Nmo5eGlaZVNINmdPbXVobzIvV0o3?=
 =?utf-8?B?ejhQNEdOVHc1ZWhYRXAyNU8velA1aDNWSUdFZG9GTC94YjEyZW16QnllSmgz?=
 =?utf-8?B?UXZMVVI1cVM2M2w2SVhZdllaYzlFVTlnUWl1TlFyYk1CSXFIdng5WHp4MmRt?=
 =?utf-8?B?aGVtSFhrcFpaQ0lhZ2xJQnpmNEF3Q2Y4M3ZyVlpuL3U3Zk9UQlprTUp1aTRV?=
 =?utf-8?B?bzgzUXRqZFQwYTJDb3FBTDZVc3kvMWpWOUdDWkNUVmpLcm01T0RWNWZmcG9i?=
 =?utf-8?B?cVk0TDgrc1pMdE5VcitWNFZvRFJzVExTWG5WaU9lSGtwcEJqb3YwM2FzMGlU?=
 =?utf-8?B?VE9aTmY2MG9HTDU5YUU4U3dkUS84TlI1YlJyOVZydXpydW9rWGVCZmJHZXg2?=
 =?utf-8?B?eFpXZm0xTUNKcDBTdy9YQ3ludWNtZ0hITHNzNFp0enVyRythZWt1VWJYYTlL?=
 =?utf-8?B?b05JS1JuOFBqL3pUT0Fpb0piekhuSmRpczJuRXJQZ2N2ek1rMXdqMTV2UlFq?=
 =?utf-8?B?MmprNlVoK2FDWmhpZ201SEh6dHFLQlB5bUM0VW9aelJQRmRIOVdUSklKeWY3?=
 =?utf-8?B?WjVMZDMrMXZVNlFKTkJid2NvQUxhbFE2UDNLU08zWHNpRzk1aGM5U3VVbzNI?=
 =?utf-8?B?YXplUGdOZnp5d1BnOWhKMDNhcVBsT0czaWNxaE1YVXNWZUY5cEZIbldYQ1Qr?=
 =?utf-8?B?RmNRQnZDU212Y1dralZGM1hKd055azBsNVZlaXUzNWY2ODNwWGF3VEo1c1ZN?=
 =?utf-8?B?VkI5YU0wN3M0UGE4blRvdmJPUjNmeElJRENWZG0zcXVxVXRrazFDMFJCdkJW?=
 =?utf-8?B?R2pCL2dNRVRDZEh6RWlwVFNTUUFueHJRVTQ2OTQ5WXU3TEhKOVJHNWx1bmo3?=
 =?utf-8?B?RW9qMS9qZzNCeDVFbFdqNklqVG1PKysrZ2VObkx3blpjZjlHSndLeCtLYjI2?=
 =?utf-8?B?ZmdFc2FQYW1iN0ZRVlIvaEJEcEJqWXNWQVdIYkJNczNqZVpqUnVlWjdkN0Rt?=
 =?utf-8?B?L3FhVXJ4bWtwZzJZMitKOEZFTjBUN3R5eVIrTWFFc0JGdUpZbk05UXBIc1ZT?=
 =?utf-8?B?Rnc1aUV1bXRIVlJoMTY2Vlg4V1dPNllidThnVmFIanR6ZEw3V0JqaUFmblpV?=
 =?utf-8?B?VDMvaFhNWGZKNVZIdWRWbEZ4Nm9hdzB6TmRhL2VZZk8vYm1PVFZxVi9zZUNm?=
 =?utf-8?Q?Oc0s=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 108a1fbc-4e0a-4ffa-27cc-08dcd1071588
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 19:39:13.8469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BDq5wbk4rPP+GU5ZxPIspiWXYF9d1ysiL+3gvQo/3sutQw1rgm30jJhH0l6wOVbk/4gBe7j+wWkiAU6HbciYWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7716

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
(or <500KHz) because write register is not quick enough when PWM period is
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
 drivers/pwm/pwm-imx27.c | 68 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 253afe94c4776..06840742017ed 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -27,6 +27,7 @@
 #define MX3_PWMSR			0x04    /* PWM Status Register */
 #define MX3_PWMSAR			0x0C    /* PWM Sample Register */
 #define MX3_PWMPR			0x10    /* PWM Period Register */
+#define MX3_PWMCNR			0x14    /* PWM Counter Register */
 
 #define MX3_PWMCR_FWM			GENMASK(27, 26)
 #define MX3_PWMCR_STOPEN		BIT(25)
@@ -232,8 +233,11 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	unsigned long period_cycles, duty_cycles, prescale;
 	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
+	void __iomem *reg_sar = imx->mmio_base + MX3_PWMSAR;
 	unsigned long long c;
 	unsigned long long clkrate;
+	unsigned long flags;
+	int val;
 	int ret;
 	u32 cr;
 
@@ -274,7 +278,69 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
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
+	 * period will not filp the level. This will result in a pulse with a
+	 * duty cycle of 100%.
+	 *
+	 * Check new sar less than old sar and current counter is in errata
+	 * windows, write extra old sar into FIFO and new sar will effect at
+	 * next period.
+	 *
+	 * Sometime period is quite long, such as over 1 second. If add old sar
+	 * into FIFO unconditional, new sar have to wait for next period. It
+	 * may be too long.
+	 *
+	 * Turn off the interrupt to ensure that not irq and schedule happen
+	 * during above operations. If any irq and schedule happen, counter
+	 * in PMW will be out of data and take wrong action.
+	 *
+	 * Add a safety margin 1.5us because it needs some time to complete
+	 * IO write.
+	 *
+	 * Use __raw_writel() to minimize the interval between two writes to
+	 * the SAR register to increase the fastest pwm frequency supported.
+	 *
+	 * When the PWM period is longer than 2us(or <500KHz), this workaround
+	 * can solve this problem. No software workaround is available If PMW
+	 * period is shorter than IO write.
+	 */
+	c = clkrate * 1500;
+	do_div(c, NSEC_PER_SEC);
+
+	local_irq_save(flags);
+	val = FIELD_GET(MX3_PWMSR_FIFOAV, readl_relaxed(imx->mmio_base + MX3_PWMSR));
+	if (duty_cycles < imx->duty_cycle && val < MX3_PWMSR_FIFOAV_2WORDS) {
+		val = readl_relaxed(imx->mmio_base + MX3_PWMCNR);
+		if ((val + c >= duty_cycles && val < imx->duty_cycle) ||
+		    /*
+		     * If counter is close to period, controller may roll over
+		     * when next IO write.
+		     */
+		    val + c >= period_cycles)
+			writel_relaxed(imx->duty_cycle, reg_sar);
+	}
+	writel_relaxed(duty_cycles, reg_sar);
+	local_irq_restore(flags);
+
 	writel(period_cycles, imx->mmio_base + MX3_PWMPR);
 
 	/*
-- 
2.34.1


