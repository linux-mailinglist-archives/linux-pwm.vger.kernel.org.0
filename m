Return-Path: <linux-pwm+bounces-8023-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGEtLmPufGmdPQIAu9opvQ
	(envelope-from <linux-pwm+bounces-8023-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Jan 2026 18:46:11 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC8CBD6C5
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Jan 2026 18:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90CF33047BD6
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Jan 2026 17:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBADE37881F;
	Fri, 30 Jan 2026 17:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mXj6wglm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011058.outbound.protection.outlook.com [52.101.65.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2DF3612DD;
	Fri, 30 Jan 2026 17:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769794894; cv=fail; b=KrJsqk2pNgCPk2mSFHPyFARgcbH9d6SNb5LxEjvjFg0Rj8vX1MxcAhWnyY2Fka8CnxNQUodG7BjBHnkvgwt4n/QpDQqqYEl7sBlgLfyIrXtY3pmBrATV+e9n95YSTaa8urivx4H3ELUlgswL3KT9DIRp7wsaen9mjlL2R6Dqcmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769794894; c=relaxed/simple;
	bh=cCv76DFXqYk0iFbk1nrQ0Pmn5Nw9dRB0/34DxIl1soE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cun/N92YK77ovUWtnUVrxulTRnd23pw1dIbqVjiNQ7RATNkQYDKIYFzcBw3dqrcQGBRGes1VJg9PGxGEVsHovBc47pEolhsEIVmZGfzrsqvs1rgvE1MgJRzb1aDaxzU5eLAIz+g7+SeG9eyUA8bblX4JNDpO+kjHGfc1TowsGSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mXj6wglm; arc=fail smtp.client-ip=52.101.65.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YqG142GF/A/8amkuN1cdMm2bbF0X+m7HKAcNBdNS/ON7+QD16P3vk9L4qBD6fux8wGHVzem1mq0VpjoHBsJKO9ateVabFI/jQ7mwZwfNxEH9Pjbbm19IZUH3YtN0ArMlfG6bc0jsd7KMDM8q1zmKDp/JNV6vbXC1ypoWV5WIzU7V4/GKjtBtrbgEs6nv+pL2brzZ79SMUwjSvRNqNXLWUFVRYzupq8CsJ+c34KVFeh/DL1Min7eQFt8fTbG7j7KbE3u+I8CQ5UMQQCRmkLDhH4ZWjRK+EQSqfwfZmab+tugi7gCqWn7sX6pY9gnvRytfetYI/P90zEfc04KOkW/7Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8joyB14IRWdL80olGaN0n6bIw2VYXeqMe2qex+UGBKE=;
 b=sp9KPJIvh5mBVJwFjqNHamf1kIS66uBF1aMZcJvtwTl6Biwr9WAKqAUTGGmi1ZMtzEQR5L1t6KEb0fysDiHBEEJEgj2wNVZr/LwajYEOfUAnp8HHtc2nuYhxsRaCeBLyabVLJWmQ9/TMoz3F2UQ0xXmVB4/KchnwjgXc0EQh13+x9YT53YczgRA+oXjCIoOE9LeBeWl5NfzXK0mcyRBMxLhB4k3KjmbWHzJ8AqL+c8fk7ANVecq+63M53TspqejwYJXP8O1aNGD9DjLzo6wQnc8RoxgDTn0rr79SZbWPiqZTVV1LdhX1VmnEFTTMUNtMuFUS/s00kUwThN9cLkLKcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8joyB14IRWdL80olGaN0n6bIw2VYXeqMe2qex+UGBKE=;
 b=mXj6wglmEVsBiO7mDkQEjYlp7pzZ9PYOQDWteEHs9M9gWWOfXw+SZHZeID2HG+cy59Za0jKY/nq/Wk7jcJqlqo4PSqFdRkBgcA99sVGvcPQQdnKPth3+NbC4j56GrxTAznuhQeuArIxlomMZn0EOgq7Fj2SfJ7GgbMek9BWMo/goZ3ezXvqeYE7kzQPokHCpyLV9q5xOqsaAxCgQj5JTBq2xVyrl1Oei8TaC+RfCVNVJxUWHypmwTnAckUptsWMUqHORWRxsIUlcF079NL4RaK8tZT/GkWyjHMT8CSancpOMKZG0eIH5v3mkLiW4QuSIogQESuXUFQkVMMYvxVhpFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI0PR04MB11537.eurprd04.prod.outlook.com (2603:10a6:800:2cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 17:41:29 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 17:41:29 +0000
Date: Fri, 30 Jan 2026 12:41:22 -0500
From: Frank Li <Frank.li@nxp.com>
To: "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pwm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: imx-tpm: keep channel state instead of counting
Message-ID: <aXztQkefafsgFJvN@lizhi-Precision-Tower-5810>
References: <20260130143720.778514-1-viorel.suman@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130143720.778514-1-viorel.suman@oss.nxp.com>
X-ClientProxiedBy: PH7PR17CA0060.namprd17.prod.outlook.com
 (2603:10b6:510:325::24) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI0PR04MB11537:EE_
X-MS-Office365-Filtering-Correlation-Id: 66bf6003-dee4-49c6-3f07-08de6026ccd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WTZMtRzDPQ9ri3pO87Lgjoxo2XK/Apusx0Vai5utPNoaocXARj/f6cMBCWbB?=
 =?us-ascii?Q?Pjv6zIRmnyqRjeG7naX1Enp3gCxfbPVtKIsqgDq6Wc+VGLf1V4u2cMKsZylG?=
 =?us-ascii?Q?oYZk7nB15CmQipGGbdeCCCmD+wZvBwn8XYNmgRSOZE1AgIQRUSbJ6Dw5GsBd?=
 =?us-ascii?Q?ik1v7r3DxeFLz5ojhooyVXljwhKNvOeclVpb2zCjksYbgKhG9sPOpvLz/Yb7?=
 =?us-ascii?Q?jfnKyAeqZsu5hnTOGxxrB1RLdZ/he0xojLJDMbkBHybejrlzA3ZiYocyB3JQ?=
 =?us-ascii?Q?b4CbC203fTMs0XEU7J7yrfvfHEcdvIk9fpBfe1B8rj2LKBlqUGaDCB5Q6Ni+?=
 =?us-ascii?Q?aALwLdsF+CYch68hCG3wI9l6yBik447hBUc6hpZLfNCjxwJgD9DBkh/GB0Ol?=
 =?us-ascii?Q?HVWA6nYabuds0YlBTEE1Soq26MbWL5BagGk43JKu1dsLmTo5t54UiutS0TRo?=
 =?us-ascii?Q?Ozp1U9fwUluCGqzzlRbi5qGLi738lcCsAqu7g+wO8pjpGI1miwSTTIKinBDh?=
 =?us-ascii?Q?BazlEibwtmCfQKXWXstOKZP68NPksCcFNWexKOdEoIiiZV1m/O4aOji7bQU6?=
 =?us-ascii?Q?Rd/H9h8T8xtpasRCwj/0P37otthu8iEwc07AD1IPERVcBmqlVy0jbcKClNtH?=
 =?us-ascii?Q?a0M8/jdaTpzw7URT7Cf7K1l2ZM9l3YYGL6WUwWhe8lM8LYYYG1Iucg9vJC+N?=
 =?us-ascii?Q?tl/bbcQeQrWd/8Vqvvy1jRtwycjyimyD/hg1B1gtVdK35USxyRnJ6ustpVw2?=
 =?us-ascii?Q?S/V4NUNOpUzC3GyRUxJth2yJt9l6c81KaJ6qtkBFPoeV2HTMYt/EsmbXBW0m?=
 =?us-ascii?Q?BnkQjRcWWC5a+2iB6M7UpauQk7jvQ/sqa7js00fMsEPelXvmqZs4qwBskRrO?=
 =?us-ascii?Q?RWEEjKy7cXDqFxK+962GOQwAg6sEA5IcPqtyi7uLV5DTjgt2o31Gd9gG2dap?=
 =?us-ascii?Q?iOkkd0MkUp3DGtjvA6FPu2FzQ6KkRb3r0/zZmSk4uUfzDNioj8Ctlm1QhmpW?=
 =?us-ascii?Q?6SxH2TYPwsVTRAxH1g+LfN8eb+yL2y2CsAxqXHHfKwz1oC9p93xDlDcwxfAc?=
 =?us-ascii?Q?UvEzwBRNo6MsdqBFltEOnhc3w/0Ka1yJj+nY2Kj4Be4hw8lQZxuAosVOGNLc?=
 =?us-ascii?Q?HsBNLnMf6iGtTuppEL0DjgwkLwyudeJj85UOD0Iw/GJ3O3zpxRxdlgz3DRFC?=
 =?us-ascii?Q?zF51dssoUDtzx6Hrp6FtI+oe9FtqL4T32MKu+ygci9adNJIRX0OnHyWzlxET?=
 =?us-ascii?Q?32jc6FtE+MjVHgWW3b5kC6savqhgTi0ImBr5EFas1dmNTx42w5h0Ca00y528?=
 =?us-ascii?Q?YjsEoFo+VsdzVBJlhAqkxtZkKFXv8cY/oL+9El75IbLCWmSshFqv4OMGKPFf?=
 =?us-ascii?Q?q5DOCbkTO7MYYcua3xqafwqS0Zzzx2O7gCJHxxz+nxWWGw68IQT+8HuIJeMF?=
 =?us-ascii?Q?LHl52P30Y6LI9DLrxn6gn2j+B4R17lonVQrJYvJumipvxTBqLPfL68JbW5cP?=
 =?us-ascii?Q?HTpbMvYu2d29tnKiCplmZIAOCLHtJSpOiQ4Yrc8fKc7PKk9lvVm7j53iIcDB?=
 =?us-ascii?Q?0uuKc1GGY5f+/UEvcojWhwu16/uhbmh4lphvMHVEccTtntV815150lmRf1Hm?=
 =?us-ascii?Q?+Mdz4YuDbSnxEhLtBBpzL1E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6ECUhT7LARe5MKtcM624iTKmohmfxsrH5aPzcdY5wmGCNUbybbEBg8HIvOqT?=
 =?us-ascii?Q?sD3vVtq52ox7my1ABs7NJMD6Yz1wosDNuzzJORNGRfDmwK5smCUbcHKwQ2uv?=
 =?us-ascii?Q?9JCr/w2NwwIIrbqJovbGkd9R5PgFf2tNgbvYCGpRXk3zLcqRGSyoDNAdKxmZ?=
 =?us-ascii?Q?7QUf6/wqvWfUhYSPcVGO6zy0KmPYYY+pMVB4h60MfctWcRNFOzcPyH3mYVAp?=
 =?us-ascii?Q?rHwM5CguUM3yKluEb42Gvl5oLX0Vai0NDJ+cSinE3JA/ZyWkRnDH/mo0KGMe?=
 =?us-ascii?Q?XWhz2ukDm+c5mehIPBhTmbbdfqPMcZW5Qp7yf3LMa9YCKa3G6vmy06nrA//T?=
 =?us-ascii?Q?jBa2LcchY3yhVFlZyBbZPq8fIiU5pSffyxiYms8ZIOYXLtt8cPzIXeQQQFEt?=
 =?us-ascii?Q?THKE2lFjFWedAkGz48yiMK4H6mAdkbIpg8jCMNvG+1rwFbtiyMkDfyYZjW9e?=
 =?us-ascii?Q?Flbq6bcChVvGon3bdKF7VElBw3YOWaQ2thz4vflJLPdNyrxJkzz6DUHGgd4i?=
 =?us-ascii?Q?oiC1Pv/f720jQ5OIAHsY44fwtcG9hplSVAype68Kn544vkXfVImwzDdKFbMV?=
 =?us-ascii?Q?aPiB2v7/6s5MyU+lR4gtyXCE9t/sQ8LxN4zw6d0lXjoChBSnOnte2Ygl6CPX?=
 =?us-ascii?Q?dlAUUCvJwU8MI+heWoRs7sZor5qcwWmECyLZBX0HdGEQu+vC2FnJmRgLLU2F?=
 =?us-ascii?Q?yvGsKtfRyk5QF8Rji2KasQDYYHIERduk1tsz4QzwN9K9DNIFpH3x1IBxvMh9?=
 =?us-ascii?Q?jLmSGA0boqvwP7fW/l2azPJquo0aQLtDJyujLLL4Yv0CfEix2/IIHnF6vRtI?=
 =?us-ascii?Q?OZuEudUwxvuwletOx6WB6Le+JTWKLrigcPaYhDcX7Psqr64GkZD/HR+cDu95?=
 =?us-ascii?Q?yw7jhW2iCkT8WuBktq2ucTe0WxM3OrOobVWyGSp/jND44Me2QQH0+S3IDWlJ?=
 =?us-ascii?Q?gV/gdOoPIy8BwWvdDFxDaK5yu2kgoGkr44yD+Aon9cyHe83xny1qmg2PfzmR?=
 =?us-ascii?Q?jue/7ACZoO2+Dp0VBEApSuEKMhmh9/eggPKxehGiT+JppyKVZRP8HryG4d/w?=
 =?us-ascii?Q?ctGpJHUXBATxP8jRobIWLdSVRCjIS35HrXR0isEkQ7fpCnhkB0LLmzlJyyWC?=
 =?us-ascii?Q?pUt6L1x0ZTgtkA0jP/zKpE14wI40RiXeSPnSBF9aUFp0HfTnIgVGDuwwsvNG?=
 =?us-ascii?Q?Bo7RCrEE8oXtt5ZAQDdC2Sv4bsXzoNYlV00dyJ+YOOb9TS3PhrYxXLQZS46e?=
 =?us-ascii?Q?5WXpEh22XHL4rTZ8rjh9NPi0rDSaKNIJTCslPx4hxjEKJTDWNvMUKICzYWB6?=
 =?us-ascii?Q?cyHbm4Gx2Zev9KtDwX2gTEQ411Nv7B3isyjBk1Yb3pgPaavLWTwmRZCQTrTf?=
 =?us-ascii?Q?xobqJLRFCNN10WtS63X8cRrWvWWS5smcAI1D1Ke4CmV/e3LYDLh+mqACVbf2?=
 =?us-ascii?Q?tWu9YlbuHvbVjMWVcrZXlJ40IK/dLJBzRF603nfxmPxfgzuq+8KrngJhcA/a?=
 =?us-ascii?Q?cjkxvAElPsnrExWytcDcwbRpAFmuGE/5UtrU1N+EVtoBNiOyJcz0x2OpdFNm?=
 =?us-ascii?Q?RkvlBiiB0YQ2pfQMEeBBAqqkCxf5DZOuBOEBSgcp1cFb3UdWsY4aat42eyi3?=
 =?us-ascii?Q?ClnQ8mZg8j2+lc1IrNLQGhDXGuFRogma3ip0IBSEoMKMIpEs31TXQrLDnJsJ?=
 =?us-ascii?Q?9Wffa1D6RDQNmti391fNfjMp5hnmtilmhgKSwO5r5plqKgtv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66bf6003-dee4-49c6-3f07-08de6026ccd6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 17:41:29.6503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vWUab94RR/s/jMpLh3jKA5qBmR/04hlvSgJHXV31PzLrwVk7O8Ss7skOIBgAL9XJvs6a+aFRE4V5jhDTQZmjiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11537
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-8023-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3FC8CBD6C5
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 04:37:20PM +0200, Viorel Suman (OSS) wrote:
> On a soft reset TPM PWM IP may preserve its internal state from
> previous runtime, therefore on a subsequent OS boot and driver
> probe "enable_count" value and TPM PWM IP internal channels
> "enabled" states may get unaligned. In consequence on a suspend/resume
> cycle the call "if (--tpm->enable_count == 0)" may lead to
> "enable_count" overflow the system being blocked from entering
> suspend due to:
>
>    if (tpm->enable_count > 0)
>        return -EBUSY;
>
> Fix this problem by replacing counting logic with per-channel state handling.
>
> Signed-off-by: Viorel Suman (OSS) <viorel.suman@oss.nxp.com>
> ---
>  drivers/pwm/pwm-imx-tpm.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
> index 5b399de16d60..0f8643f4a70b 100644
> --- a/drivers/pwm/pwm-imx-tpm.c
> +++ b/drivers/pwm/pwm-imx-tpm.c
> @@ -62,7 +62,7 @@ struct imx_tpm_pwm_chip {
>  	void __iomem *base;
>  	struct mutex lock;
>  	u32 user_count;
> -	u32 enable_count;
> +	u32 enabled_channels;
>  	u32 real_period;
>  };
>
> @@ -166,6 +166,10 @@ static int pwm_imx_tpm_get_state(struct pwm_chip *chip,
>
>  	/* get channel status */
>  	state->enabled = FIELD_GET(PWM_IMX_TPM_CnSC_ELS, val) ? true : false;
> +	if (state->enabled)
> +		tpm->enabled_channels |= BIT(pwm->hwpwm);
> +	else
> +		tpm->enabled_channels &= ~BIT(pwm->hwpwm);

Do you have lock for RMW? or you should atomic_or() and atomic_and()

Frank

>
>  	return 0;
>  }
> @@ -282,15 +286,19 @@ static int pwm_imx_tpm_apply_hw(struct pwm_chip *chip,
>  	}
>  	writel(val, tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
>
> -	/* control the counter status */
> +	/* control the channel state */
>  	if (state->enabled != c.enabled) {
>  		val = readl(tpm->base + PWM_IMX_TPM_SC);
>  		if (state->enabled) {
> -			if (++tpm->enable_count == 1)
> +			if (tpm->enabled_channels == 0) {
>  				val |= PWM_IMX_TPM_SC_CMOD_INC_EVERY_CLK;
> +			}
> +			tpm->enabled_channels |= BIT(pwm->hwpwm);
>  		} else {
> -			if (--tpm->enable_count == 0)
> +			tpm->enabled_channels &= ~BIT(pwm->hwpwm);
> +			if (tpm->enabled_channels == 0) {
>  				val &= ~PWM_IMX_TPM_SC_CMOD;
> +			}
>  		}
>  		writel(val, tpm->base + PWM_IMX_TPM_SC);
>  	}
> @@ -394,7 +402,7 @@ static int pwm_imx_tpm_suspend(struct device *dev)
>  	struct imx_tpm_pwm_chip *tpm = dev_get_drvdata(dev);
>  	int ret;
>
> -	if (tpm->enable_count > 0)
> +	if (tpm->enabled_channels > 0)
>  		return -EBUSY;
>
>  	/*
> --
> 2.34.1
>

