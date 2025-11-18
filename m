Return-Path: <linux-pwm+bounces-7636-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 64442C67881
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Nov 2025 06:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 303542A1BC
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Nov 2025 05:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3277D2D4813;
	Tue, 18 Nov 2025 05:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FBUZ/pTR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011048.outbound.protection.outlook.com [52.101.70.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD5E2D060D;
	Tue, 18 Nov 2025 05:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763443039; cv=fail; b=PYHTqg8MuDvnfl2kElyVjnO5HKSQD139T/vQ2E+AoAfzVuGAwhk95JS7YRYJ44Zt6pS0mDzKXwyPn0WA0HLvwSOJkhjrLUcibeKwwZx1tRvdOVGyMMMjOzcxiTIeMJOACo7rwfvxfPrruGIEj8hljTnS3c46POcZXnXeYvFk1As=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763443039; c=relaxed/simple;
	bh=T901+DFcfwNGcBAGz35B4t4OnhxWffFNVLMKsgp1Eu0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MIkp1/IN2Kp/c0/1EoEKy+VFJ1ATz7cLDarmvZOiFEtx2HDlzWdDkfZIonVntO4GShZj7g8G+ctaKROOSgzDpZ7ogM9oUsAg0Qf0FEAJSnPIT3KyWw1kzHFj6OWnqdBpL+RLbWieno5mAAWq1kTrbmk/JKG5Mn7o8YsdaWRBrig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FBUZ/pTR; arc=fail smtp.client-ip=52.101.70.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STKiXw7r2bLkDyacGHJDrb80qKfkQ0MU96+AiVG3NAFTMWRuM8BwAGErY/8079oZgQDoWk2oVELTUmEqZsdvloKNAXs6k6HEw7tiG2eSpxF6ReYTsTP6A+UG0KKtGg3/FRp3GHo35cMOvIMImZHoFjIpQGr5n+RFcL7tIePx0I7PEktVvk064vlg8IC8w7Pt+T7TFfPnS0f7SfEkmc1Gf+xa7ZX8QX61wmmW3Gaiop1gvnnMx2zycZD24jG8BYg2u0zcvUlFDDX1Z5QKk/rfVqR++LjFxAZG0NuX4hvir2bFEl3mTozCKoCtgZJZHz9g9XQXDk+KNwTWDvbkRkdRbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MlKP6pzsD8BHQ/2Ey7menhpXJ6MUIpi4OheOy16CYZE=;
 b=j9SZK2k0jq3nNPvbkIei1GV6XHpdzOAi7L5bMJG9kt6Lb47A/13b5ndm6QEu4iSrSHttG6C8Yl9krZy645YR0miH7o577V3ccf+5Xe45gNHjmHTREuVXMbku6ow2lseVlJHVTS+augZGQnzrR7hmaQi+nObbs5NGUyFvRVEdy3NDdrWKZHxZCVe0n+YCcKB2cQecQby6LGcQMHkXW3Gis59qDy9QOHOETbBErwgcbuoJMef9JA3VKAJ7wi3ym1Ji5KvFgLY5Xr/05q53+vRxAFJqvAawnxqpn5X1TE15zAbe+Yy6d23wr8PmPyLUZQklICqqYAlNFZiOJ1dW9ccjCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlKP6pzsD8BHQ/2Ey7menhpXJ6MUIpi4OheOy16CYZE=;
 b=FBUZ/pTR1D2JaVujgKt6hDyg796p0T0Hb9OB0B5v3eIgPtZr+ctvB5vpzUAwaDskrr7wkrAGFSqO6DcHTDDPIyDo2PJzrP1t1ce8WgYMu551RBPRKvKzhGHy01SzqOID5jWkWYVnw0Lmrc3CZx6ZPcezor/22AGOV+IES0s4onQbRGUQoqY2l8o5jMBaIgnh8MPSv7bwbKSmolZaIRSOV/4ny8QUJu2ygCKgFQosyeiN4wNPj399+odcQXHKYF8pFPFYKkbup7TcfazPNBAVWsmuhu+7gJTwyAszl4QKpcPtkBlSRJzovGe66IG1iO4+k6/xC1Wt3PB6M4X0nJv/ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DB9PR04MB9939.eurprd04.prod.outlook.com (2603:10a6:10:4c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Tue, 18 Nov
 2025 05:17:11 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%6]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 05:17:11 +0000
Message-ID: <6dab993d-2462-4771-81d4-2f29e9cfffcf@nxp.com>
Date: Tue, 18 Nov 2025 13:17:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pwm: adp5585: correct mismatched pwm chip info
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, ziniu.wang_1@nxp.com
Cc: laurent.pinchart@ideasonboard.com, nuno.sa@analog.com, lee@kernel.org,
 linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev
References: <20251114065308.2074893-1-ziniu.wang_1@nxp.com>
 <jqsmjigr65kqhlk3buybrcurllqxlad6zkkuwo3tea5uqopqzl@ldwbjsndltpk>
 <34af5576a5e779a279975dd9fb8be7c2b233f661.camel@gmail.com>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <34af5576a5e779a279975dd9fb8be7c2b233f661.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::8) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|DB9PR04MB9939:EE_
X-MS-Office365-Filtering-Correlation-Id: ae5b3ab5-3443-4a5a-a59b-08de2661ba13
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|19092799006|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Y1JwV09ZblhWcVJzS2RBSG42RTlnOUVnbG04ck5xRERjVE1jMmhlcjhhbFJP?=
 =?utf-8?B?UGRlQTZiekI5eXNic0tXUy9wcCtOdy9iTndKaGlvRk1pZnVseDlXSDNrNDFC?=
 =?utf-8?B?SytsYm1IUTlFM2dlUnRtbkVOdGREYjc5Z1ZUUDlRM3dMUnhHeDROUjJTMWU3?=
 =?utf-8?B?YWlFcGZhemR6UVRFNlVNNTd2ak9keFJ6M29oUCtkUFZncVVkLy9XbWExYlA1?=
 =?utf-8?B?NHAzL3N5ZjVLYU1EUHZ1Sm9YU1d1WHpsT09seEk0dnhnZFJVR0lZMFZmMXVn?=
 =?utf-8?B?U2EvdWNxaHlJWmNHeWNCMS9sMG1maHpnMzJueGRpY3FFRmpIQmhmYzhPcnRQ?=
 =?utf-8?B?WnE4L21seGYzaE1oWnVSbktqYjBhc1Q2ajBXSmh5VU95YjhSY1hmUXlFRlBN?=
 =?utf-8?B?OEJaNmJMYnhqeStmdzJuSkQ5S2NzTno2NHA4dDAxcERid1VpWWNDWHAydWhP?=
 =?utf-8?B?YjZWNG5TSlQ5cmpVa01PdFFaUUY2RjQ1OEdlRWNjYVRXc1BDRWIyNjJ1Q0ZT?=
 =?utf-8?B?ei9WWWhJUGZzaEVtcjM0enlJYnVXemcyV0dYVDN5UmNDMkMvQnJLdFViaGVw?=
 =?utf-8?B?a04yb0VidVFLaWYvWk8zL3dqQnlDOFVOTGNxcytNQmVLZ1gybDQ1S0NTOWx3?=
 =?utf-8?B?NURXM1dLZUhtb3YweFZqbjZ6VE9Eem9jeWlaL1NkSzN1czBlRnlrVlpXWmMy?=
 =?utf-8?B?dDFDdTBSY1JLQlZrcGlKSlVERTh5NVp1MEtyRHZMZ1JFZTI5ZnhSSkFEVFdi?=
 =?utf-8?B?WWFxeEhjR05WcGFlbUVVdkU4S2dEaU1BbmJNbzBjVGN6T3p3NEJpbzBVMGJq?=
 =?utf-8?B?SE1PNlVHVEJoK2JVUi9DS3dmc1IwVjc4emtjTThiRzFlY093eWN3R29xSTlT?=
 =?utf-8?B?WHlwWno1T3RnNVcxKzZ2N3hrT09vdkIwRy9YSHhFLzhnN0UxTi9Jek9vTUhD?=
 =?utf-8?B?Nk1hdVA3REFKdi9VbURMd1J2T2o2aURLUXpjYXZjTEZqcEpmSWpSbFpUZExQ?=
 =?utf-8?B?S2F3N1VVc0xCVjU0bXIvVFdrTElWQzlzVnIxbGViWWhTWWltanBBazdjOVlQ?=
 =?utf-8?B?eGlRY1IyTGJPNWo2cjhLaTJScnJ5b1djK0FzdDQxUmUvamtweG5GVjB4dkli?=
 =?utf-8?B?WXpIMk1MMzlZYU8zbENlajA0UTBLM0R6Y1JuUGtXUXlQdEtQRkRUNVUwcTFN?=
 =?utf-8?B?K3Y5SUFDTDQraXQ4NUJzT0JXVFJkQVhwdEFwZXBoZEs3K05uUHJuNEhLRVc1?=
 =?utf-8?B?dVY4d1JYM2psamg3alQ1SkU5Nk9TK29WNTV2VzlxSHQ5SnlXbVY0TkRzSUdX?=
 =?utf-8?B?MDhHSnJMUFdLdGVRVnAyL0VCK0lEVTlJZXIwZUJNK3FvMWhUSFlDSVd1dHll?=
 =?utf-8?B?aXJPYTJGWlA5a1dtWXU5UWRHWWorZXRwaGdnS0NwKzd2b3Fncmg1TzNGYzFQ?=
 =?utf-8?B?NGwzR2lIV09Sc1FRV3VTOU9zSFl4d2tHS2FXbXNpRzJ4WHVMTi83T3BRdmdm?=
 =?utf-8?B?ZW5Ndm1oNEFodEQxT2dnKzlMYWtWZitESXRNaFh0RXBUOTVXNVo2amVUT2Js?=
 =?utf-8?B?eHAxZ2pzcHFpdTg1ekZhQ1I4dlpvYmMwc3Q4N0tXSlVTL2d4cktIcWJBcHVx?=
 =?utf-8?B?MGNYeGh0SWRBUmZCd2oxblZOYkRiNkZTMW0wTmVaVDBnYk9NRkU2dmRKbERt?=
 =?utf-8?B?alJVb0E5MmtITWpvU29hZ2VJdmN4VVZ4NDMzbkJSNDYyUm5uRXR5SEhoUExL?=
 =?utf-8?B?Q055VENIUnJFMWxRWjhvSjBMd2FFS3JxeThkcE5DK25hcnplV1BZVjlnSGNu?=
 =?utf-8?B?MFU1K2JvZldjT3Y1R1FpR08xbEd3QzZMTHQ5eXZhekRGb1RPUXVVZHdYMkZ3?=
 =?utf-8?B?T2lkMjZEcmZFM1pqQ3J6bEQzdDFvdnlncWg2di93c3pIVS9STlNqYlE0ek5Z?=
 =?utf-8?B?d1QzdzhxSGlkMk0yemRpemNkUFdzSDRUbjhseGtVaXBjRTV4eDFjV1A1SERE?=
 =?utf-8?B?bWswemVkUFJ3PT0=?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bW5pVHVTaitSY3g5dUMxMEdUUlJUZzd0OUdqK29MYVBzRkpaR1BTcnl6N0Vp?=
 =?utf-8?B?OFZTNmdseHJUOE1sT1hCNy9JNmZpb3dsb1pmWHVNN3RGVHEycnRIZmJTQmow?=
 =?utf-8?B?eDYzakp6OWJvQnBJZkxycjZxTFh4MGNmOTA0ejdIWFVsOHNRWGRyeWs0Y0Uy?=
 =?utf-8?B?SEVLQ3JXUTlpTjVONnlrZnp2ZGU2bUZzRG9uL2krVUtVaWNhNkJMMTJFclV6?=
 =?utf-8?B?WmRaNUNWcytENFR1alFNQzhDbUNpSkVqTWI3L0FZNmZJQkdObDdxeUNCSjVr?=
 =?utf-8?B?RlgxUzNNdWhVYWZ4aVEwdW5SRVIwbGV0WjdKVlVWSnJzMWE3d2xHVkJpWW16?=
 =?utf-8?B?S0RuTlhZcDFPaTBuWCswZE1FRWY2OWpCbG9TRC9FczZzZFhIQlIxZDBoOUtG?=
 =?utf-8?B?R1RyUHgxNU9tbHllbER6RDFua1FzbUsvQm1FaEQ4QUdVc1VYMENRa3hvbUd2?=
 =?utf-8?B?OUpaMmo1dUVMcmdYcU9nT2N0elFVaHVnd1ZicjBSejZTeTVha2dzUmsyVlB3?=
 =?utf-8?B?NHpDbUJGdDQrTzNrSGpuY0R1THgwVnB4amsrU0wzcjZYa0RCVDZaOVJvdEFr?=
 =?utf-8?B?SjF0WlJWeVVNNDd3UTdFd2grZUdjdlBwcHEwcmNKZEFydWh1QzQwc0dPTG5h?=
 =?utf-8?B?TElhL3orYzNueHhqMDRsaVVOWXJoY29pWXE2aFFXYjR5c3N1Yk9xdWpnUVhK?=
 =?utf-8?B?REZDRHhFN3B0VjhMbVM5d1YrSUJxZXBkc0RwYVpEa0ZGNElhQlpSL1M3aEN4?=
 =?utf-8?B?RHFvcTc0eGR4cnpXNUxoOG94eUdEWXB0aFUzdmkvSHFwSXhkT1pDN2tybGp2?=
 =?utf-8?B?bjJKSEl5bmVjSUltZFhuTHJuMyticHJ3K1hpdUw1R2h0WE01SzZTVzRpd0JF?=
 =?utf-8?B?ZnM2dDFBQnp1d3RISkx5SVhSRk1QUmpTcU1nSk9xRXcvUk1MdVpUTHpLRUhY?=
 =?utf-8?B?Z0wrT3lCZDJRMkpxemtKNHEycE5reUF2ZUlrMG9tUm1oZkV4eWJMbW56RFhK?=
 =?utf-8?B?bkd4NEpQY1JaZEk0bjR1ck1qRVlNYlNBUDdaN1ByY0J4V3JxZkZNUHQrRG5I?=
 =?utf-8?B?TWYxcmtYbmlXZVd1d2ZGYzJLZG5HOUJVZUdVc2Z3UkZoMmxjbkpkVE9JcVo5?=
 =?utf-8?B?VGFoRk1vN29vMlFWbUcxMUY2QzVZZ1Z4cFVLTk5tU2J2RFNaYTFoYWVGeDBM?=
 =?utf-8?B?cGV6ZmRldUFpclpPaDNWeFh2bmtQS2ZZSTFxaVVWeERVVmdTQkgwaTZZanhX?=
 =?utf-8?B?Z1BjNkN5dFNGWnkyVWptZ0xmeWs3K1duZ085VGhaeUxtOWYwd0xFVjNaV3pE?=
 =?utf-8?B?R01OVHRrWEtpTEhHNEFpZy82VGdwcVVQVWFBczV4TkkxSEp3RWVXQzlzZHh3?=
 =?utf-8?B?WUluOHd6VXZWSmduNHROQzJybmYzQlJ3M0gySXRvTjB0OG53T0dweHlDei9C?=
 =?utf-8?B?Z250eWlGWEM4QnhWVDdPVkFOcTExcjJOQjFENGNVWEJZa2l1MnhKU0JzVlVn?=
 =?utf-8?B?cmc0MVZVUEs0cFg0blNwYXFucnJTN2ltaENPaWNCc1ZocW1HRHpNc1dGNmE1?=
 =?utf-8?B?YnpyVEJ6VThrOE9TazFLM0tGRVJySHZlTlg4OXN3VTE2ekJIYUJaSmpEbWFV?=
 =?utf-8?B?c1N5L1MrOEEzSmg4clZrelNwYU5zY3VublQ5d3pXU0lDS09nRWNzSkQ2T2h5?=
 =?utf-8?B?N2xWei81VW5GRm5DU0xwanZnZnhoUUhWU1hpeUhzVytTMXlteXRmcERRM0tB?=
 =?utf-8?B?UkNkYTRnTWpJVjhnaXVIY1EyM2FWV0oxekRTdkc0ODVRMkNUL0Q5SkRsdnc3?=
 =?utf-8?B?Ky9wQ2NaQVJZeHFTaTBuRkdOQndqaHpoQ3d2SEVoN2tJT1ZYOGlDeXJ1NVVL?=
 =?utf-8?B?WHI5ZkR3L2I1SkxvdCtndlpwUHBWOEhBKzJ5eDhFZ1B3OGVWUHNXK0sxaldX?=
 =?utf-8?B?NzViR0JuV1JiRDg0TUdmT1BkYnk0YTR3OWZnMldDOWtvTlBJZ1MrVE8rbXBT?=
 =?utf-8?B?SnZlekswejdxNGlxWlR3Q0JHKzR2TElWMnBpV0dNeGFYS1RUM1AxdnpKVEVi?=
 =?utf-8?B?aFM4SVBFaHJ2TG8renVBNE1YNW5Fa0xJR3ZGdVBzVnFScDk2Y3NHR1lhTERw?=
 =?utf-8?Q?vdDpeMhiTZ81yd4bxxj+X8sFX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae5b3ab5-3443-4a5a-a59b-08de2661ba13
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 05:17:11.0887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kUCjFP2HYCbTSY5E/mm40bXm9RZo2X8UEco3uRRKeE1DGruxTda8kyNvVnwz7PCBnrRAPUew7O+K9wi9rsNxfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9939

On 11/14/2025, Nuno Sá wrote:
> On Fri, 2025-11-14 at 10:30 +0100, Uwe Kleine-König wrote:
>> Hello,
>>
>> On Fri, Nov 14, 2025 at 02:53:08PM +0800, ziniu.wang_1@nxp.com wrote:
>>> From: Luke Wang <ziniu.wang_1@nxp.com>
>>>
>>> The register addresses of ADP5585 and ADP5589 are reversed.
>>
>> My German feeling for the English language suggests:
>> s/reversed/swapped/.
>>
>>> Fixes: 75024f97e82e ("pwm: adp5585: add support for adp5589")
>>>
>>> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
>>> ---
>>>  drivers/pwm/pwm-adp5585.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/pwm/pwm-adp5585.c b/drivers/pwm/pwm-adp5585.c
>>> index dc2860979e24..806f8d79b0d7 100644
>>> --- a/drivers/pwm/pwm-adp5585.c
>>> +++ b/drivers/pwm/pwm-adp5585.c
>>> @@ -190,13 +190,13 @@ static int adp5585_pwm_probe(struct platform_device *pdev)
>>>  	return 0;
>>>  }
>>>  
>>> -static const struct adp5585_pwm_chip adp5589_pwm_chip_info = {
>>> +static const struct adp5585_pwm_chip adp5585_pwm_chip_info = {
>>>  	.pwm_cfg = ADP5585_PWM_CFG,
>>>  	.pwm_offt_low = ADP5585_PWM_OFFT_LOW,
>>>  	.pwm_ont_low = ADP5585_PWM_ONT_LOW,
>>>  };
>>>  
>>> -static const struct adp5585_pwm_chip adp5585_pwm_chip_info = {
>>> +static const struct adp5585_pwm_chip adp5589_pwm_chip_info = {
>>>  	.pwm_cfg = ADP5589_PWM_CFG,
>>>  	.pwm_offt_low = ADP5589_PWM_OFFT_LOW,
>>>  	.pwm_ont_low = ADP5589_PWM_ONT_LOW,
>>
>> I wonder how that didn't pop up during development of 75024f97e82e. I
>> would expect that the driver doesn't work correctly in a very obvious
>> way without this change?! I tend to want to send this to Linus before
>> 6.18, but the question makes me wonder if I'm correct with that
>> urgency. Any insights?
> 
> Yeah, this one I kind of asked for Liu to test it (as I was not testing the PWM bits)
> and he did tested it [2]. But it was v2 and that series had some more iterations. So
> I suspect that I messed up along the way and the last version of the series was not
> tested (for the PWM bits).

'b4 diff' tells us that you introduced the bug in v3 and I did test v2
although I didn't provide my Tested-by tag.

b4 diff 20250521-dev-adp5589-fw-v4-20-f2c988d7a7a0@analog.com -v 2 3 | grep -C3 pwm_chip_info
Using cached copy of the lookup
---
Analyzing 203 messages in the thread
---
Diffing v2 and v3
    Running: git range-diff a99fa5bf804f..d382f21d8d7d e1940c40e7b0..4dbd46335b23
---
    + 	return 0;
    + }
      
    ++static const struct adp5585_pwm_chip adp5589_pwm_chip_info = {
    ++	.pwm_cfg = ADP5585_PWM_CFG,
    ++	.pwm_offt_low = ADP5585_PWM_OFFT_LOW,
    ++	.pwm_ont_low = ADP5585_PWM_ONT_LOW,
    ++};
    ++
    ++static const struct adp5585_pwm_chip adp5585_pwm_chip_info = {
    ++	.pwm_cfg = ADP5589_PWM_CFG,
    ++	.pwm_offt_low = ADP5589_PWM_OFFT_LOW,
    ++	.pwm_ont_low = ADP5589_PWM_ONT_LOW,
--
    - 	{ "adp5585-pwm" },
    -+	{ "adp5589-pwm" },
    +-	{ "adp5585-pwm" },
    ++	{ "adp5585-pwm", (kernel_ulong_t)&adp5585_pwm_chip_info },
    ++	{ "adp5589-pwm", (kernel_ulong_t)&adp5589_pwm_chip_info },
      	{ /* Sentinel */ }
      };
      MODULE_DEVICE_TABLE(platform, adp5585_pwm_id_table);

> 
> [2]: https://lore.kernel.org/linux-gpio/3efb68e2-7091-47e1-81a2-39930da5a427@nxp.com/
> - Nuno Sá
>  
>>
>> Best regards
>> Uwe
> 

-- 
Regards,
Liu Ying

