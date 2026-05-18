Return-Path: <linux-pwm+bounces-8945-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNL3FiGOCmq43QQAu9opvQ
	(envelope-from <linux-pwm+bounces-8945-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 05:57:21 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FDE5658B5
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 05:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A138301DCD5
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 03:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627573806A3;
	Mon, 18 May 2026 03:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XY3sAQoh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011018.outbound.protection.outlook.com [40.107.208.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86EF1FECAB;
	Mon, 18 May 2026 03:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779076625; cv=fail; b=mx2BGXCvL9mJBtxaHJNNB0K8KP0raN4v3O2PxO7xj+Lt61S457d64HAG/4tnVAHWfrASJDCET4Ofp6asq/6r/9lzT/64k6F9e7zPUGRny1EnIUkDKrcRzTrUaKhXrOUtMICS8TRgpr1oCZ5a/wL7wT+e8/NPBmnrMAWZgvHeEuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779076625; c=relaxed/simple;
	bh=tPEbkJcQhrqzNDEVvOkOSiroOv+iTkTy0F/rpMxbv3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p4mAuxGXwAkjewb0Wst68pjksuXSt+XIn3AHIm5W4NOYrmXTHUvnFE1bCE1tb1Pn6qvsn5FhZHqEVGfiyOqCSfoOPy3bHVgn2AIYSEv4XQesogRF6+V2KbbfAY92ScVbhhqcDfdWldR+NOF7BHZvKOVIayIhqyLvHk/WAdGykx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XY3sAQoh; arc=fail smtp.client-ip=40.107.208.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hF/IL8l0Hf48kvadepT3kp/wTDGdaleXDl+VxswIx52br8IfYws12KawU8Qojf3Tn3bIUhtn1n0DV6fc+qPb3gtH8+m2L/38wvOBl+ggbV4Q2mPAe1X3fJG5vsXjFNCMzt4/ep/k1120ERObAlYp4PBuHhS00NjSywpucdd/knfKV+lc8KUpNZfqw7N8OLBrjZbUz0Uuh8vaFvIhzuSAbQkq29ttVqJ6oTiUBQDdHJTELh/Pz6DQkoah/pc1MUl6sh+CM6GKwiBSibiwS/AL4XvjfLxz94BMxQuT8+MLLWszpXHWTQuX/2VfOqHJLod/4RP16x8/CMPn3qPJWZdDoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xuaMuidrTX7CPCP3fmvOLUne8WkKlKadZ85BkveoKc=;
 b=mYIqzXhoUy5RwR+zsMOP/ypUOaUzin2V2683eQ2MC+uD+1HTp0iXg2sCSyFd8flj/o81wnNmN+v6ytv6KKpNwSXU28h9ZmFnKDUQF+K4JbKcd6O3RoIcsSHV9AdjRWLrmVOYNu7FUP+Qx6OQ8RVZoty15dO3DaxGP7rOCoxQAt3H0r2RrceMPLeWYI7bU1GdQe5aPzgqZY7bf05QfhHnUHqkrWW/LUzB4jLwlSNiJVRVpxIBqo89RjF1d6dTyp/9UUJ0N6i0P2S1cUKEk/FQ4gDif74bYCbFKR5YCcykI5kJTzMrEeUJLrI7gaqAXRe7A/WN0wqJvaYdCvKKp5uGAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xuaMuidrTX7CPCP3fmvOLUne8WkKlKadZ85BkveoKc=;
 b=XY3sAQohvhKBxMzslAR0GjZgCudDKTF79tl5mgNGuRQbVe5T/+KUCnd3WbduWEzfbe40CpVMcewDyMjNYxFPkIx8P3ts8o5z52k+wDFsurStit7HGEcr51yz4FtKvpN5ncvpQYnJxfIGkuia9vm2PdhdFyOOkXcA5u6He9PC0CrPc3EZvy4ZKsqC+khmAEpfyM0AW2nUBzJqDPQeGpWOE6AKZ8yui0okOcYDWi4h8XEMp8WkWhsygODuMecg7KBIlg+7SWsbsbPiUjiV6SjtiV8j8cd6mO4J+iwErwhXhBe1Df+mbjUSl5lKAGfH25eugRghUp5+i98e9Ea/jIHleQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS0PR12MB7972.namprd12.prod.outlook.com (2603:10b6:8:14f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 03:57:00 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 03:57:00 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Yi-Wei Wang <yiweiw@nvidia.com>
Subject: Re: [PATCH v4 4/7] pwm: tegra: Parametrize enable register offset
Date: Mon, 18 May 2026 11:30:22 +0900
Message-ID: <JtkNSow1ScKHJF9O5ji4Xg@nvidia.com>
In-Reply-To: <agn7SP3ETY4XCX4h@monoceros>
References:
 <20260331-t264-pwm-v4-0-c041659677cf@nvidia.com>
 <20260331-t264-pwm-v4-4-c041659677cf@nvidia.com> <agn7SP3ETY4XCX4h@monoceros>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCPR01CA0129.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::16) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS0PR12MB7972:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a31b091-4e7f-4994-be76-08deb4918346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|56012099003|22082099003|18002099003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info:
	cTSJh9e33niQmSs3tqNfqw0JHRIwRRUGYhzBBT+SfeUcN9XV2D6toi8oM1PpGEk/urfGOEFxPjWQyjGJKi4mm1ysDbikWpqShVZLt1/eq8jR2iWfcFgUx/8qhClFcn+YqtV+aPnbhrd+3yncOz/pv6MPQrvfVxh1hDVhjxrVQaM+rFwweSBXF835n6odla6HoLUmevcfMOFV5I70WLgZjvdm4CQWJOgCBzGDEcD8NVaW/j4X0xN+8X2wNYC+0aZFY1XVPzKJS+7oCFEJ6lknmO263EF0ARKLKWVwqUJUhHqbpW1E8133CqFCCPXMzIZ34ZuWyW6MiWeHT5uHTanYHAERBnCW5yuSy/pFPcZvZnUiNcQLioMf8avfbhvLLSWlV4Mlfk1oPazy7/tKRcSByAPaMnFcQD261CGRU8y1uUnH13HpDJ0bcSQEeo4VtuzTFdcMtjdgQu4UpZRC/v2px3JJdMYHX2HGE2G1EPtcb32XYsMBnqS7b7zKqCB7BD/OMvUM3O2elRfNklgHRPysS+S5jAJxVTxA70Psju8d3jGYTWXZ2QFDFRFvuWgv6/3Uru32/rwYtZmjUUTf9lA8mT6uaq9RpNrbKCT74ZswWHf32FZQkKIRDSSmvyPmb4psX1UGarCCOZbL3/qs4aU1NLWkhfnpwMLpbTfGiY+05KHgz00r8V5PSVKyG460Kbi9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(56012099003)(22082099003)(18002099003)(4143699003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmYzb0M2NmNnUWo1K1lVaE04ZHFTM3gvcGUrOUxQNE1yS2FrK1ZhZE9PWlA1?=
 =?utf-8?B?NGtjYXM4bDNEZlNQUnNYWEpNbmkwd0JaU1NWRXNVNjFJL0lmVmRYUFJ2Mlds?=
 =?utf-8?B?MEhVczJOOFVVM0FMWDg5U3Uza0xzVUF3TWdpUDVWNEFSUjIzYk1kbmh4dTQr?=
 =?utf-8?B?My9FZ0pRVC9jdnE3dnZTTVhNZzd3dUxNL1lVb25weTM0eDhWaWh0TXVCRm5r?=
 =?utf-8?B?eHdDS3VjQU1JWGhWMGNDY1h1VkJVcGFVQXBValJzWmFiTGRJYlNvVGdJMGpU?=
 =?utf-8?B?djkydm5DMmZ3RzlCYnBzUTBZSThRMHBEc1J0UlBoR1VuWmw0c3FwNFhFYTBR?=
 =?utf-8?B?cUNmN3BPNk91RGYwWmxuenV4Vm85RXYzTkw4TjN2eGR4UmtwNGVWOFFwa1JG?=
 =?utf-8?B?dlhMdnZkYzdEZy9NRXl6M3JYRC9OdHowc3hhQ3E2M21Da05VQ2V3Z1ltQWls?=
 =?utf-8?B?aS9TdXppZTMyUFJvU1BrNVAzbERhc2R4cW5QYmJkYjAwYlRTdHVObzk2YXJ1?=
 =?utf-8?B?QS9Zb1Q3bzh0dnA0cHd4WHM5aGNCS2FjdXRmcTM4VnVZb1hNRzdjeUlYSTVj?=
 =?utf-8?B?dloxR09SZUp5Z2FqTURXQjJGRmRGVll4Ry9rQVhianR5WEtpUVV4UW11NEty?=
 =?utf-8?B?RG56WWtVMC9UV3oyd1NxK1VpYUt2c21WRUcwdTEycGxSd1ZtTE1YUzZTZHEw?=
 =?utf-8?B?aFZUc2JBTC9QZXBQdStwU1VLaTdmSk5sZXlUT1ZxZ2R4R3BOTWJIN2tKcHBh?=
 =?utf-8?B?dElQUm8vK1BkZitYV3Z2cDlURFlud0NTS2h6VS95d01Ycm1rVVA5K3FBMFJp?=
 =?utf-8?B?Z0hCNmNsOEdsb254ZXN1Ty93ZlZIMjBrNElLY0QzRG1PcmN6WVZuU2FHdEJz?=
 =?utf-8?B?SUVKKzNnTFNNMzQ1bFNITXpDOStoZzZsakVIRnFOaWc5cUZybFNNY1NucHpF?=
 =?utf-8?B?dHJsQ25oRk44OTVMTUtGeXhEdGJpc0g0WkxqSDE0YXNjL25WU0kzaHJ0Z1k1?=
 =?utf-8?B?VG1kSWJDVEx1ZTRpWlVBbDB4OE4rUUZxeFhxdnZjaytRNGE2WG1lWGtxdEh4?=
 =?utf-8?B?K2d6ek1KdG82Yjl4elZ2RXVZZFJ0SlJpNzl5MFh4OHFiUDVVZ2xmS3BTdTZ5?=
 =?utf-8?B?a2xFSlZSK094YTVrcEZVK29oYW1sMHNhd1FBTURqNGVlOTRGYkJYelBiUm1M?=
 =?utf-8?B?Y0UvV0tSQjlKY25na2NpdlRLWmhqZDZwZ1ZRY1JNZVNhUWtldXBVMm5GRnN4?=
 =?utf-8?B?VFg5NjR2WDNlczZFK2xRRjRWbkVpek9oRjhsMHdndUMwV1Rra3JRZEcvQ2VP?=
 =?utf-8?B?N2l1T1FiWGZpeVA2UmJoWWNxLzBleVlPTnR0SjRMK0VrSmtVU0dGNnAvNkpX?=
 =?utf-8?B?aHI1QVBDTlRsekROS1A5MkRWbGdNMHUrd1h6RWdhWTlNbUpodGxENllsTEZn?=
 =?utf-8?B?VGJMWHZJS2EwMUFYeXZ4SlcrWWdQeUsyN0l0aGREcVgxRG9yc2lmeFZQZGFX?=
 =?utf-8?B?NjB3TW9YUkxwNXV5QTZHMnlxeUVVbHB0blpBSENPYzEycFZENG1HRnpjbGFx?=
 =?utf-8?B?S1h6ZjNVZXZ4cUtZYTVIOTlPa1premVoRHp3NHJMZFNBSG9rTHpKck84QjNj?=
 =?utf-8?B?bGt3N3BhYjJiV2F5OTZRalBQWHJhVVNEbXRianZkYVdyZEN4VXJDVEFySWRj?=
 =?utf-8?B?TmNEQWFvRjdzWFlEdHdTSVJ0a0o5K0o0anpWemFubnRmazk4Z3pCL0FLRlYr?=
 =?utf-8?B?NCtJUTR3ZkVIa09yeTRpcHlLYlBwdHdMeWVkN1lnSmg0WXptY0tQSER2RHBX?=
 =?utf-8?B?N20xaFhNdTB2b3Nib2lpTGlncm9adExER0lMc0hheFVvdHM0ZmRmcGx4VWg5?=
 =?utf-8?B?RVowTFB1cERtWEpoRzJHYXpESHpuazhRajdGZWpkWXFxR2t0bjhzY3FsT0xW?=
 =?utf-8?B?cXZlbGNpdlphbmE4RWhKSEdIUWc3bSs3bjNqV2FHNXVpREVza0FtOUVLT1Vr?=
 =?utf-8?B?V2RHcHg4enVGek83TUtYWmp2YWh1bDB2TldDNGQ0RW9BaElsVklnWEpwSUYr?=
 =?utf-8?B?UDFMT2djcXluMVFBSHVEU3RQMXlobnM5UTRKMDRKeDhDZ21UM1NJWHlNRzBO?=
 =?utf-8?B?cTFEZndhZUtGcmYxR0dFenVvZ05hT0Q2NHN2dUZVQjdpeDFHS1VHWjdlVU4x?=
 =?utf-8?B?RWN5ckV6MElQN0o4R0lHeUFkRWdNK2NVRzJrUnJVNXpUOHNKam1BSkhIa0Nv?=
 =?utf-8?B?QWYvRWxxNzdaZW1YM2NiMG03c3ZOOGJuQmlwMXVTTHZjTlhNRiswQWZIdzNj?=
 =?utf-8?B?b3pKdnkyYTB1YU11V3dKUStXZHR4Z0lCZm8xWlBTb0VoVEh4THZkaDk0TFNi?=
 =?utf-8?Q?gm5YRIzr3+jHhfcyHkqJxxvYHEKaUSAYHx0VoVPDvgjua?=
X-MS-Exchange-AntiSpam-MessageData-1: cRdMQt2kGie1Ig==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a31b091-4e7f-4994-be76-08deb4918346
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 03:57:00.0893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6uppeAQpkrWfwI2yaGO1GSiMddteDVKl0InXb1IAZhDDjlJevwgLSXjCvrYCEDUPMG+TcavwLEZXXeqFWpXB6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7972
X-Rspamd-Queue-Id: B4FDE5658B5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,nvidia.com,kernel.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TAGGED_FROM(0.00)[bounces-8945-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Monday, May 18, 2026 2:35=E2=80=AFAM Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Tue, Mar 31, 2026 at 11:12:16AM +0900, Mikko Perttunen wrote:
> > On Tegra264, the PWM enablement bit is not located at the base address
> > of the PWM controller. Hence, introduce an enablement offset field in
> > the tegra_pwm_soc structure to describe the offset of the register.
> >=20
> > Co-developed-by: Yi-Wei Wang <yiweiw@nvidia.com>
> > Signed-off-by: Yi-Wei Wang <yiweiw@nvidia.com>
> > Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> > ---
> >  drivers/pwm/pwm-tegra.c | 17 ++++++++++++-----
> >  1 file changed, 12 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> > index 358c81cea05b..b925ef914411 100644
> > --- a/drivers/pwm/pwm-tegra.c
> > +++ b/drivers/pwm/pwm-tegra.c
> > @@ -61,6 +61,7 @@
> > =20
> >  struct tegra_pwm_soc {
> >  	unsigned int num_channels;
> > +	unsigned int enable_reg;
> >  };
> > =20
> >  struct tegra_pwm_chip {
> > @@ -197,8 +198,9 @@ static int tegra_pwm_config(struct pwm_chip *chip, =
struct pwm_device *pwm,
> >  		err =3D pm_runtime_resume_and_get(pwmchip_parent(chip));
> >  		if (err)
> >  			return err;
> > -	} else
> > +	} else if (pc->soc->enable_reg =3D=3D PWM_CSR_0) {
> >  		val |=3D PWM_ENABLE;
> > +	}
> > =20
> >  	pwm_writel(pwm, PWM_CSR_0, val);
> > =20
>=20
> The patch is a bit artificial because we don't have a driver yet where
> `pc->soc->enable_reg =3D=3D PWM_CSR_0` doesn't hold. But it looks strange=
 to
> me that there is no enable bit set for the pc->soc->enable_reg !=3D
> PWM_CSR_0 case. So I tend to want these changes in squashed into another
> patch such that the combined patch handles the enabling completely.

Patches 3-5 are all preparatory for patch 6 which finally is enabling
Tegra264. Would you like all of these patches squashed?

FWIW, the reason there is no pc->soc->enable_reg !=3D PWM_CSR_0 case is
that this function only writes PWM_CSR_0. So if it's anything else we
don't need to take care to preserve the enable bit. It's a bit janky
but I wasn't immediately able to find anything nicer without a larger
refactoring.

>=20
> > @@ -213,6 +215,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, =
struct pwm_device *pwm,
> > =20
> >  static int tegra_pwm_enable(struct pwm_chip *chip, struct pwm_device *=
pwm)
> >  {
> > +	struct tegra_pwm_chip *pc =3D to_tegra_pwm_chip(chip);
> >  	int rc =3D 0;
> >  	u32 val;
> > =20
> > @@ -220,20 +223,22 @@ static int tegra_pwm_enable(struct pwm_chip *chip=
, struct pwm_device *pwm)
> >  	if (rc)
> >  		return rc;
> > =20
> > -	val =3D pwm_readl(pwm, PWM_CSR_0);
> > +
>=20
> A single empty line is enough.

Sorry, will fix.

Thanks
Mikko

>=20
> > +	val =3D pwm_readl(pwm, pc->soc->enable_reg);
> >  	val |=3D PWM_ENABLE;
> > -	pwm_writel(pwm, PWM_CSR_0, val);
> > +	pwm_writel(pwm, pc->soc->enable_reg, val);
> > =20
> >  	return 0;
> >  }
> > =20
> >  static void tegra_pwm_disable(struct pwm_chip *chip, struct pwm_device=
 *pwm)
> >  {
> > +	struct tegra_pwm_chip *pc =3D to_tegra_pwm_chip(chip);
> >  	u32 val;
> > =20
> > -	val =3D pwm_readl(pwm, PWM_CSR_0);
> > +	val =3D pwm_readl(pwm, pc->soc->enable_reg);
> >  	val &=3D ~PWM_ENABLE;
> > -	pwm_writel(pwm, PWM_CSR_0, val);
> > +	pwm_writel(pwm, pc->soc->enable_reg, val);
> > =20
> >  	pm_runtime_put_sync(pwmchip_parent(chip));
> >  }
> > @@ -398,10 +403,12 @@ static int __maybe_unused tegra_pwm_runtime_resum=
e(struct device *dev)
> > =20
> >  static const struct tegra_pwm_soc tegra20_pwm_soc =3D {
> >  	.num_channels =3D 4,
> > +	.enable_reg =3D PWM_CSR_0,
> >  };
> > =20
> >  static const struct tegra_pwm_soc tegra186_pwm_soc =3D {
> >  	.num_channels =3D 1,
> > +	.enable_reg =3D PWM_CSR_0,
> >  };
> > =20
> >  static const struct of_device_id tegra_pwm_of_match[] =3D {
> >=20
> > --=20
> > 2.53.0
> >=20





