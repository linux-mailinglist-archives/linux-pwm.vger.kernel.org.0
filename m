Return-Path: <linux-pwm+bounces-3215-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B180C975CAE
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Sep 2024 23:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AA55B212A4
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Sep 2024 21:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFC8155CA8;
	Wed, 11 Sep 2024 21:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Aj6+OU0u"
X-Original-To: linux-pwm@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2046.outbound.protection.outlook.com [40.107.249.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5331428E4;
	Wed, 11 Sep 2024 21:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726091747; cv=fail; b=cuH8XXd5+UAsTnBnFKYk4nNNmaB4uswt9BsExypo+38Oxo2Id9V06orNbrZOoMCj2bh7TZLvBcv6QGXIPCEogwl6LUCXHU6McijBYhulYZ3fUOc3VIhMJ05wZjM/wONeMifl0g9thOgEfO+tb4P44rkFmZJBn3AeMkpXWBaXkV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726091747; c=relaxed/simple;
	bh=y1r1cew9cFd5EAxacnWKCb7BkDQsDP8DM+s2IpwZEGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RTTI7n1620VPf7ZxA4TPbfHCrTTgRNlciqeHkkaGIjgkfOCHzipocdMwA56xhy3lPjVowR9YFabOu0ZKqt1BIBCOg3cKJ5sv5WVIkF+5pEigtxf6m7DjvycIjLW8KgDoZpasujsuGeH0Xb6/DcexROGwNWILlAZ1dyKxQ9C4UDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Aj6+OU0u; arc=fail smtp.client-ip=40.107.249.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UyCKa/20OVZNbnwDy8uJP6E+5/jAquyGGeGmuP7YBSAhLoma1C82qTaTr5UC54xzbFnCse3ObcKnPn+nCglFoaUNIJdVxkJ0nJrb3M88fyPBLhTUvZZ+TkapdUAEhgX3dRMeFN5LWPkygkZ59aEQksxWbVP6YR8XPYLweGUHZ9Ypp7YMiNinbPgxXVhIpuaBzycdkfL85QiB7rrg4S1mTj9Dn7vpnZmIaTz9W8DFKwFMffVLZQr4wp3nJb8TyZM4AwLzZpkv6sFhX9vEyQU8f6hCX3KndlOJyNa9y1YSaIxy/rdg9SuMuqGB/bsd9iP+SoMhE5D7ySxDjZWJOsiWvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gh9mGc4wYdfZh/E2GF4citzqzPr/HuBCPC/nUZADal4=;
 b=JQ+uFqo1U2SG+Q4dmDMBtc3EQwFPihwwJebcG1Hdf3l2vcj5CBrdRLGvjfm28nk6Lg0bl04S4jR/VmufSL1k+lpMGjQegMBW9GdXOyl7DDieMKWM4GHDuYROOlVeQXsaYf45eTYsx/1syexE576nEaYZR0EXGQO0uXkhPQN9lny021ufi5WKV89JsgDcHlU8LWo3ySofYI8KDup5v84Y3CCgFVbLLXfABOwqDTu5mhS+0XEGyWTaS62D7sczqBk3gvpGeU3H4YswMRg+Ux0bcCk/cybu/cYOFs0/6zrUl6FukCU6hIR1qzKp2Su9011mTCWylfydETv+nnw18lzfDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gh9mGc4wYdfZh/E2GF4citzqzPr/HuBCPC/nUZADal4=;
 b=Aj6+OU0uY0z67tW46NRTysyGINMCEwa5F9RAG2xzbPBQ8PsQHZ5vH7z6HAeOYyUi50fRe/1XqfGVMparnvvxReRDUqL970ec5Pki30FQ10PnmsFLOGf2nRYphO74PMLHUf+dcYHaboI4JUtOVeTXBdaQasieW+ccATu9uU+8MjvmAGL7jrhp8DPRwoLYIHw8hPATgbPJRCfpgWUeRVRxfmLS5XsMCYylyU56VfsFDCimLD58OT7/KqJwI4dDkHLOxqyFGutC3dHaPzrf1AzhIwtDew4odRZpCAmEWkr0BJcWozSok8xLl7QmZcjrJvXWogC7d32Wcu5MUGO3uouvbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9596.eurprd04.prod.outlook.com (2603:10a6:102:23e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Wed, 11 Sep
 2024 21:55:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 21:55:41 +0000
Date: Wed, 11 Sep 2024 17:55:31 -0400
From: Frank Li <Frank.li@nxp.com>
To: Marek Vasut <marex@denx.de>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
	francesco@dolcini.it, imx@lists.linux.dev, jun.li@nxp.com,
	kernel@pengutronix.de, krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, p.zabel@pengutronix.de,
	pratikmanvar09@gmail.com, robh@kernel.org, s.hauer@pengutronix.de,
	shawnguo@kernel.org, ukleinek@kernel.org, xiaoning.wang@nxp.com
Subject: Re: [PATCH v5 1/1] pwm: imx27: workaround of the pwm output bug when
 decrease the duty cycle
Message-ID: <ZuIR04pr59mepdBB@lizhi-Precision-Tower-5810>
References: <20240910152455.2425152-1-Frank.Li@nxp.com>
 <f42fefb6-2815-4f74-b403-fecd2aa79688@denx.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f42fefb6-2815-4f74-b403-fecd2aa79688@denx.de>
X-ClientProxiedBy: SJ0PR03CA0168.namprd03.prod.outlook.com
 (2603:10b6:a03:338::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9596:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e2aef24-4ea5-461b-1722-08dcd2ac7a7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkJMOGdzS09NWFZYZUNiNExXRVJoY0lpcWJ0M0syYXpRdklrdGcxNlJaV29N?=
 =?utf-8?B?dmdCdTcyYzdNb2k0K1NuT3dvMk54c0p2ZnNOKzgranBvTVdHR2FUd1E2Vm1w?=
 =?utf-8?B?eFFaamxtRXRpcHo2c0xwMFY2VHFVWWVXNkY0ak9EUnVLOXBxekhDSHU5eTBl?=
 =?utf-8?B?K3FZRVdTVFFHZk4rZUw4QlF5SGErdm1QTnhmOS8rZ2x2dmpYK3ZTYlRPdExJ?=
 =?utf-8?B?R2ZEeFc4dGpSaElRUFpkRFgwSTh1MjFTaThkL2ViczRWS0NONVJVeENWN1FX?=
 =?utf-8?B?aWV0WjJnWHA3dDRhMkZXUjhZSDgzSkFnbmJOZnk4U3pIZ2MwZWwreWZPYjZS?=
 =?utf-8?B?aUJybUl2U042ZGsyaWNFSnBQWGV0YUM5U0FqUG5WZ2Z6aUJOQmUxWXlDZThD?=
 =?utf-8?B?bS85cWlIOW1vdE02Z2tOdGg2Z1l0QzlQOENDNVl1S0d4cVFDdHJVWUpoT25W?=
 =?utf-8?B?eVIxMkxEUEg4ZEJRdHlSU2JsQnlBMEE0ZmZtWjZqcTVlb1p5SHdsMktqaDRI?=
 =?utf-8?B?Rk9BZmtSb05CZTJYS29UbWJUL0pFNkdKMUQ1U1ZraWxIVEdmb2lFUWFGd3h2?=
 =?utf-8?B?L01FSTB2VEgvNnpKSm5SR3hDQ3JjbnZ3V25ld2s5U1pJY2tITC9UdFk2Y2tr?=
 =?utf-8?B?UHZOaXNsbWpkSFFNa1lJbzJRRmhJcGJoRW1qVkQ0MzYvVk1VVUVTSWw0UXY5?=
 =?utf-8?B?aG00RWFvTmFMaysxcks5aTcvemU3SGRteWJDemtwb3NYT0xwMHFIcHFaVkhE?=
 =?utf-8?B?eVNTMnNpVEFpNVAvbjRPZTZPdXZuZDVNYU9FWUFEWnBMaVZLVlhRNnNzUGJY?=
 =?utf-8?B?dldjUzFLVmZYeTdNalJFRnBBeUxEUGkrcGNtVS9VdlpqVHd5azNFUnRXbjZZ?=
 =?utf-8?B?dlJNUTNoT3BYTzFkUGQ4emo3SWRDblJ6Z1BYRFV5b2Q5YTZNcmlaVTVVM24v?=
 =?utf-8?B?UG1oTTRZYlNVWjVXVFM3Z0VIYnp2ME80SG40RFdTVlFFeE9nWWNERmF1ZVcx?=
 =?utf-8?B?dmpucXRGaHJmWmNpOFdjbXdrbHBhMittWjdVV2JHeEhRYXlXNXhZa1BNN2RN?=
 =?utf-8?B?aVorb0o1bjRGRlpHMzU5QzdwME9wMjlDMmhZb1Nua3RJUU15emNtZFVraUpY?=
 =?utf-8?B?a3JUY1RWelNLS01VN2xGMFpiRWoxOW8yV1F0L3Z5TE1taDczNktMc2lvajln?=
 =?utf-8?B?L1ZPbVdhRnZrc2JKQlB3RDZXc0k4dXpGa1pQek5SUDdjK0F2SXFPTDZxa3px?=
 =?utf-8?B?ejZSOVM5MnlvMkpFa2plRUpmT0dBYWMxODFIcDhwTTFaVHo3dlVLeC9jVkpp?=
 =?utf-8?B?TW51S1NheXpvaHRTQzl1dVhqMTE1NjE3RFd3NVRDOWdEVWtTMFhWT1FZUXZh?=
 =?utf-8?B?UkNOaUREWHFDTlJTUGQ0S3hJZXFwZDAyYzUxOEplYjBwN1ZQRGFzWllSWFNl?=
 =?utf-8?B?VHFTZEFDZE5aYjJSczNQYllxSzlabHg2ZmdEQVRUMzBtVXo1ZGc4MGF3VWFB?=
 =?utf-8?B?Qk95TTM5ZkZReXdQVVJCRjBNM3VaOTZlTEJJZ2dqaVU4VWwxcnNJUi9ML201?=
 =?utf-8?B?WHNpdUJqMjdGenhGWmk3cTQvQ3dsbnE1djBFa2pzdUxaOEo5S0tpaDhoSlk4?=
 =?utf-8?B?T2h2bGcyN1FPRjc1RWJaZzd6OFFKNDNQbVVxN3FQUnEvcmJmME1kcVdLVnR0?=
 =?utf-8?B?WDJKcUpvVi9DMWxxeWdWdzBSaHVMQzhLWlBDNGpoOE9MRjJDcGhKL0hScjZp?=
 =?utf-8?B?Zm13N0diUXAvTTFyWGhtMGhhNnM4aHNJbHNwRHFWSXdvY3Z6K29nWitpb2dI?=
 =?utf-8?B?RC9wcHVlTW9GSVdQaVp5eGVEQWIzbHd2LzdlUGZPczRTa2xRYmh6dElsZk9P?=
 =?utf-8?B?YWJydUpmd2tOdkF1emlPYmxoTC84VUlWY01KVDM3Yks2MGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alVKaUFvNVlnRm9hSnJ0YVpsK3o5ay90b1BueE8raDZ3RnBHTEE5RUF2cnhC?=
 =?utf-8?B?L3FhVmFOb2MxdW40RGlTSGllYk1jWmtZd3BoZCtsdlZnVnNVb2FZeXRXbnNt?=
 =?utf-8?B?aU5mWDBEWUNiY3F0VmNCNFhWd016SHk3MDAydmFmVVhpVitxbW9QYjdSZFpa?=
 =?utf-8?B?TGhqcHB5UER2REZ2QUU3MXpsdU1ab1doQXFkU2ljcks4ODdVaFlpMUNFMWhs?=
 =?utf-8?B?UERVd0o2ZlQyd0IxSWNuQ2M0RnI1dEdkdzU2NVkvRDFreWc2Sm1BL2grN2xI?=
 =?utf-8?B?Wno5aUFqRDlCaEpBeVdNdkZydE5hdHNud1VpSFplbjZjZCtVNCtjdURiSXYz?=
 =?utf-8?B?QWdCN0U2WktOUWdzbjdvclI5YjVuK2JHZnJLWFI4MkdtbVVkcS9OYi9wOFhP?=
 =?utf-8?B?VGdQU0diaE0zbENQUFUxSjZ6VEF1QnlOOElqMFRBTTlSMDdrQ3JudnRaY0pV?=
 =?utf-8?B?aGlzcWVsS2ZpblhvckQ5NHQ0N3h2M29qcWRQclI0bHZ1V1U3ZTF3Qy9VV2xq?=
 =?utf-8?B?bitObzRuUG5pVlZQYWpZVklEbjR3MWxOVW1tUUFUcGh6VCt4bUVUY0JjeHpq?=
 =?utf-8?B?b0dsMXlEdm10NDdjZlR0OFZsWjdHa2Yxcms2WGMwcCt1azY2eWNVS1YvNEUv?=
 =?utf-8?B?TmdzZHVhQzNjaHdVbFBKRDlkT0RiZ01YRUsyQVN5RkZpaHc5MG5zcUtUUU5z?=
 =?utf-8?B?cHJtSVIrTDYydk9xWnZ6bHk2UUtXaEpYamJkV2xRSnlIRU8xcWlodjZoTTNP?=
 =?utf-8?B?V2hycVFWUWdiM1FpSnlxUlZlODk1Q2VGZGZkM24zWW14VVVrVzdDNWkrYm9h?=
 =?utf-8?B?YzRvOGl2UCtlSGNXUmVvWGtRbEl1aE1hdE9WWnJnVmo1MW9SUksvTGZzRDI3?=
 =?utf-8?B?MFc5TlFZS1h6S3NTWGtUZEYrY1BESVY0WUJCeW5Rb0VtMDZEdjRtMnI2SVlR?=
 =?utf-8?B?UmpSRGZXVFdQQzloRElybHVsMWIvUFlmRmNmWjE1K0VndWgzbnJYenJQVHhr?=
 =?utf-8?B?MWpGT2swM2lxcHY4N21sQTB4cTRQd2g1NWNHUGRLOUpqRmR6eS9keDRiSVI5?=
 =?utf-8?B?b3pQelZ0aW5XVkNiN0lZYjR5ZWttL3lQMSs5MUF4SzhwOUV1MmVoV3FoSENj?=
 =?utf-8?B?OUpxay91TGtJZ1RzZ2RIeWhyeGdSeEJkdnRyZ2VkL2p5c01ZT2VlTDBqQjhp?=
 =?utf-8?B?SjlPVXU2ZDJ6ajcxckx3SXA1dTFVZ2kyMVpXRXQzekpiYTUxN0d6ZSt5djJM?=
 =?utf-8?B?emczengvdXBIY1M1bk1oZTdvZ0hYb2ZhQVllVzFIaDBLZ2QyQkxKdzBnaXc1?=
 =?utf-8?B?ck0rK25ybzljUUZ1bElzeW9jcUs3aWEyQnV4QXVDZlFyaTQxTHlCUEd4ZStP?=
 =?utf-8?B?V3ErZy9WM3VvVkd3WWUyQ29vS1pFWlBvRlREdnNLVW01THgzSGtwY2ZXell6?=
 =?utf-8?B?aUlISkl0NVc4dVNmc2Fpc2VoVmVxTXNFbUNUVW9TQmtiK0dkeURIdzliZ2xp?=
 =?utf-8?B?cUpZZ21PSHZCc1N5Y3pPeEdieE9tSDBuaXRRUDI2dXJ4b1RzNTloTE1GUW5l?=
 =?utf-8?B?Q2pkUGxMdXgxWGN5VzJaclkydExhTVRoNUhmcU9zQjU4K3NIM0hEbGkxZTZn?=
 =?utf-8?B?VGloM2h1U1lQdE5JYXZFMGJpMDRyNWl1YTJPL09vMGZpaU1tcnNqN1hiclFZ?=
 =?utf-8?B?TE5zc0crWm4weXlQcVZaUWdHbUNEZGVmV0R3ZkVQZERSZWQzeUJTM1VkdHE0?=
 =?utf-8?B?cDFObXFyUnNvdHUrMk91RXVMeG5mRUNQanNMcC85NXhDc2tYczZYWnRZYjFG?=
 =?utf-8?B?TGJqYys3M2svay9rRmJoK3JCQXBxc1dRRjRZa1o2aUVNRW5zVC9EanZ1R0JT?=
 =?utf-8?B?RW11M2kzWGZ2dWJkVWxQTnZCYlpDeEV2VHNmUzRyV3czUlF6Kzh0LzM1YVhH?=
 =?utf-8?B?OHRlb2RlY0dsT1N5eVlwL3k2dDkyaWt0cmI3c3A2aTBuemN5KzRHaUh6QVpT?=
 =?utf-8?B?MW1USGRHTTZuNkxhenZGQlg2bW1jajNNeTZWNGZxbnY0VzUxWGh1UnFEVGdp?=
 =?utf-8?B?NzZ3bjlCYndLS1VtVE81VGNvTE13Mzc2QVZmOU5oTkgrWUZOaERVeWZpVG9E?=
 =?utf-8?Q?o8Jg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e2aef24-4ea5-461b-1722-08dcd2ac7a7d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 21:55:41.2409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nz3cjGZqQAAnRH2hC31SbKA0Wsiq/Qu2c6fQwwFjRxDyqVdy9iwioY9j2TEbTWIh53zZ0XLqpPOQYkK1v1bvSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9596

On Wed, Sep 11, 2024 at 10:26:38PM +0200, Marek Vasut wrote:
> On 9/10/24 5:24 PM, Frank Li wrote:
>
> Hi,
>
> purely nitpicking further below, one quick question right below.
>
> > This only resolves the issue when the PWM period is longer than 2us
> > (or <500KHz) because write register is not quick enough when PWM period is
> > very short.
>
> You did mention the IPS bus is slow. Do I understand it correctly that the
> IPS bus write takes about 1us ? Because of the PWM consumes a sample every
> 2us and we need to write 2 samples to avoid FIFO underrun, then to safely
> write those 2 samples, we need to be able to write 1 sample per 1 us into
> the FIFO ?

The above time is just estimated, which variance at difference platform and
impact by other IPs. If there are pending write/read from GPIO, PWM write
have to wait for GPIO's write finish. It actually depend on IPS bus's
loading.

<500Khz is very less possiblity that write slower than PWM's consumes.

>
> Also, would writing more samples help with such "fast" use cases ?
> Something like this:
>
> if (clkrate > 500000) {
>   // This usleep() could use some further improvement, e.g. calculate
>   // precise delay for the FIFO to get empty based on PWM clkrate
>   usleep(2 * 5); // wait 2us for each of the 4 samples in FIFO and a bit
>   // Now the FIFO is surely empty, write all four FIFO slots
>   writel_relaxed(imx->duty_cycle, imx->mmio_base + MX3_PWMSAR);
>   writel_relaxed(imx->duty_cycle, imx->mmio_base + MX3_PWMSAR);
>   writel_relaxed(imx->duty_cycle, imx->mmio_base + MX3_PWMSAR);
>   writel_relaxed(imx->duty_cycle, imx->mmio_base + MX3_PWMSAR);

It can help at some possiblity, but still have problem if > 1Mhz, write
will always less than consume.

If errata happen, only 1 cycle is full high. I think it is quite less
impact at such high frequency.

We found this problem by observe a screen backlight flick when change
ducty_cycle. I think we try fix it after a real user visible impact happen.

Put code here can reduce some possiblity at certain freq range, but may
miss-leading user the problem fixed when > 500k.

Frank

> } else { // clock rate less than 500 kHz
>   // Do the workaround below
>   if (duty_cycles < imx->duty_cycle && val < MX3_PWMSR_FIFOAV_2WORDS
>     ...
> }
>
> > Reproduce steps:
> >    cd /sys/class/pwm/pwmchip1/pwm0
> >    echo 2000000000 > period     # It is easy to observe by using long period
> >    echo 1000000000 > duty_cycle
> >    echo 1 > enable
> >    echo  800000000 > duty_cycle # One full high plus will be seen by scope
> >
> > Fixes: 166091b1894d ("[ARM] MXC: add pwm driver for i.MX SoCs")
> > Reviewed-by: Jun Li <jun.li@nxp.com>
> > Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change from v4 to v5
> > - fix typo PMW & If
> > - using imx->mmio_base + MX3_PWMSAR
> >
> > Change from v3 to v4
> > - none, wrong bump version number
> > Change from v2 to v3
> > - simple workaround implement.
> > - add reproduce steps.
> >
> > Change from v1 to v2
> > - address comments in https://lore.kernel.org/linux-pwm/20211221095053.uz4qbnhdqziftymw@pengutronix.de/
> >    About disable/enable pwm instead of disable/enable irq:
> >    Some pmw periphal may sensitive to period. Disable/enable pwm will
> > increase period, althouhg it is okay for most case, such as LED backlight
> > or FAN speed. But some device such servo may require strict period.
> >
> > - address comments in https://lore.kernel.org/linux-pwm/d72d1ae5-0378-4bac-8b77-0bb69f55accd@gmx.net/
> >    Using official errata number
> >    fix typo 'filp'
> >    add {} for else
> >
> > I supposed fixed all previous issues, let me know if I missed one.
> > ---
> >   drivers/pwm/pwm-imx27.c | 67 ++++++++++++++++++++++++++++++++++++++++-
> >   1 file changed, 66 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> > index 253afe94c4776..713d368f03931 100644
> > --- a/drivers/pwm/pwm-imx27.c
> > +++ b/drivers/pwm/pwm-imx27.c
> > @@ -27,6 +27,7 @@
> >   #define MX3_PWMSR			0x04    /* PWM Status Register */
> >   #define MX3_PWMSAR			0x0C    /* PWM Sample Register */
> >   #define MX3_PWMPR			0x10    /* PWM Period Register */
> > +#define MX3_PWMCNR			0x14    /* PWM Counter Register */
> >   #define MX3_PWMCR_FWM			GENMASK(27, 26)
> >   #define MX3_PWMCR_STOPEN		BIT(25)
> > @@ -234,6 +235,8 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> >   	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
> >   	unsigned long long c;
> >   	unsigned long long clkrate;
> > +	unsigned long flags;
> > +	int val;
> >   	int ret;
> >   	u32 cr;
> > @@ -274,7 +277,69 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> >   		pwm_imx27_sw_reset(chip);
> >   	}
> > -	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> > +	/*
> > +	 * This is a limited workaround. When the SAR FIFO is empty, the new
> > +	 * write value will be directly applied to SAR even the current period
> > +	 * is not over.
> > +	 *
> > +	 *           ─────────────────────┐
> > +	 * PWM OUTPUT                     │
> > +	 *                                └─────────────────────────
> > +	 *
> > +	 *           ┌──────────────────────────────────────────────┐
> > +	 * Counter   │       XXXXXXXXXXXXXX                         │
> > +	 *           └──────────────────────────────────────────────┘
> > +	 *                   ▲            ▲
> > +	 *                   │            │
> > +	 *                 New SAR      Old SAR
> > +	 *
> > +	 *           XXXX  Errata happen window
> > +	 *
> > +	 * If the new SAR value is less than the old one, and the counter is
> > +	 * greater than the new SAR value (see above diagram XXXX), the current
> > +	 * period will not flip the level. This will result in a pulse with a
> > +	 * duty cycle of 100%.
> > +	 *
> > +	 * Check new sar less than old sar and current counter is in errata
>
> Better do 's@\<sar\>@SAR@g' so all the instances of 'sar' in the text are in
> uppercase. Currently, some are in lowercase and some are in uppercase.
>
> > +	 * windows, write extra old sar into FIFO and new sar will effect at
> > +	 * next period.
> > +	 *
> > +	 * Sometime period is quite long, such as over 1 second. If add old sar
> > +	 * into FIFO unconditional, new sar have to wait for next period. It
> > +	 * may be too long.
> > +	 *
> > +	 * Turn off the interrupt to ensure that not irq and schedule happen
>
> IRQ, in uppercase.
>
> > +	 * during above operations. If any irq and schedule happen, counter
> > +	 * in PWM will be out of data and take wrong action.
> > +	 *
> > +	 * Add a safety margin 1.5us because it needs some time to complete
> > +	 * IO write.
> > +	 *
> > +	 * Use __raw_writel() to minimize the interval between two writes to
> > +	 * the SAR register to increase the fastest pwm frequency supported.
>
> PWM, in uppercase.
>
> > +	 * When the PWM period is longer than 2us(or <500KHz), this workaround
>
> kHz, kilo lowercase, Hz Hertz uppercase H lowercase z .
>
> Also fix in the commit message.
>
> > +	 * can solve this problem. No software workaround is available if PWM
> > +	 * period is shorter than IO write.
> > +	 */
> > +	c = clkrate * 1500;
> > +	do_div(c, NSEC_PER_SEC);
> > +
> > +	local_irq_save(flags);
> > +	val = FIELD_GET(MX3_PWMSR_FIFOAV, readl_relaxed(imx->mmio_base + MX3_PWMSR));
> > +	if (duty_cycles < imx->duty_cycle && val < MX3_PWMSR_FIFOAV_2WORDS) {
> > +		val = readl_relaxed(imx->mmio_base + MX3_PWMCNR);
>
> I would put the comment below above this conditional statement.
>
> > +		if ((val + c >= duty_cycles && val < imx->duty_cycle) ||
> > +		    /*
> > +		     * If counter is close to period, controller may roll over
> > +		     * when next IO write.
> > +		     */
> > +		    val + c >= period_cycles)
> > +			writel_relaxed(imx->duty_cycle, imx->mmio_base + MX3_PWMSAR);
> > +	}
> > +	writel_relaxed(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> > +	local_irq_restore(flags);
> > +
> >   	writel(period_cycles, imx->mmio_base + MX3_PWMPR);
> The patch looks good, the above are just trivial nitpicks.
>
> Thanks !

