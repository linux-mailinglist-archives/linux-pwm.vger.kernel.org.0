Return-Path: <linux-pwm+bounces-9495-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HR/VCd18RGqnvgoAu9opvQ
	(envelope-from <linux-pwm+bounces-9495-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Jul 2026 04:35:09 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 698F16E9441
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Jul 2026 04:35:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=YDvkvr++;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9495-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9495-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30F8C3018087
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Jul 2026 02:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C43355F35;
	Wed,  1 Jul 2026 02:35:06 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012045.outbound.protection.outlook.com [52.101.48.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760801FD4;
	Wed,  1 Jul 2026 02:35:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782873306; cv=fail; b=bNBohaP7vLCeeJqQl3cT4GbDd/a5ZRWCLJYsXbYZ75PJRWlPOAi6Y/g6y4PkPWSufTcKtbUB1NptazJpEPlM1iJlrS6RjH5U4qzACJT2vmwRsMcrsmD/db6XOjWNI1H4izXzfZ7/GG2/uU91/CawYd8jogZgVKIG55+hNCTPZgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782873306; c=relaxed/simple;
	bh=A61dZyE2WafuvEti+QfcwEQjzwDOBw+I5uqxWGrm4Uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JofwIJEb2SwA5QmVnsMB9V7G2S/6lsOWNJoQUoX2Uh/clJXWpnbOi82lq+IyVEv8qj0BjyHDnvKaIKz3JXGQn5xiExGMIsjGrlvU9Th9FS/pV1jeRZw6hs4uyqHpISwm8YbMvN7awrYTLAsLvuil7YOnGBmVKmFHyN5qqH2abCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YDvkvr++; arc=fail smtp.client-ip=52.101.48.45
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xCTMUxSRD/AGjB3IL3wTf2Ov0ek8cuzT7pM+TdLLF3pVQVc05ReKo+4dvs2y4/6DcqJ+AVuCkxnjg33WRRZX3OdCqVi8Aqb4RtzS8LzQ4LFgYJMZFUOIBMa8Ba5vJ2yb11To8HLy5grrEhIHkH/oVCb5npMRFwZrY+YFXZIDFBTgqIYT1LEpPU+tZnKz4K0JWGjx7s9ZyAvG83UkFnyfhbQMpgdn0K+dBMEkz5+KoCDUVNvjilb2fOww2fLw1EC5IcjJm5tajF/JaXCt8skkHYCgfOshGF81B9vafTX9eTj1Kr6zCxy/SREYTCjeFK0hrch65zBK1W9c77IPELV9Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiJrx1KOHV8gdIAc040a5wBLvOZJs2tdlS1eTXybarI=;
 b=ePQWW7mBw/s5zb2gzuBJIsoAFaV2xYXcEa8gdbuS6SFjiGhQz6JOEGZY4XYfPGaYt/tY+5DaZjvcsBTxSdVBPB625mQJmKFCz1SN1Mk1rzjVv4zzyELDlt7iu1YClpfAGJbCn224CFiJbXD2FsfwCjFzzdHjHrw6S2yirHHiqViNIyzGBFGIn91/xNA49PBxtY46uZ29eYt/5D/Yh1mXXtInOGzd9js1Juk/d4DlFLfh3E3JiNl9WWC/q/E6O//zcD9zmmo//Y3Yw/+USIbpTniur9J9nrPqOwKr07AN40ABUbUJNbNuNulq8JykH2/aVca+DOlkPILmhFP7N0Wm/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiJrx1KOHV8gdIAc040a5wBLvOZJs2tdlS1eTXybarI=;
 b=YDvkvr++n+4VoHl7g1RqzMw6kVXKxdBtJ9CPMY00jJjJ5Udjd+ia4jQKwdB6UBnD94XVEE8tuY6dcSl4eAmWLPP4tnP9hX85WeM6vo6hdEFpcYbkCA0kq4AHGdd3BvL4um56toa5xf7nu0s+z6sYRmnSgzoZhlPUUEwEe1PY53kSFhapZdT5Sv7UMS14oyAdolFTgT0EwK7AksXy1oFBtIibPEuRuNNgXpPU5erdn/jxrPxjOp8RNoK7c+w0+cgeH6/jN1LNhVmqUxi9tphGuxSVEN2G+hIR6MGMhNFk+Pzdd3VBI9GVrhbO1vqDwTdXXEoesqKgXIpDhq71sx0Ozw==
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by PH7PR12MB5594.namprd12.prod.outlook.com (2603:10b6:510:134::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 02:35:01 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 02:35:01 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Jon Hunter <jonathanh@nvidia.com>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Thierry Reding <treding@nvidia.com>, Yi-Wei Wang <yiweiw@nvidia.com>
Subject: Re: [PATCH v5 0/7] Tegra264 PWM support
Date: Wed, 01 Jul 2026 11:34:49 +0900
Message-ID: <t5mhnEQVRSmL2SdFhD88-A@nvidia.com>
In-Reply-To: <akP-KK1TUFAGXxpk@monoceros>
References:
 <20260529-t264-pwm-v5-0-7bf9e405a96a@nvidia.com>
 <add09636-7b0e-4a99-8503-d98a75c14f4c@nvidia.com>
 <akP-KK1TUFAGXxpk@monoceros>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: OS0P286CA0112.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:169::20) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|PH7PR12MB5594:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e7f335b-eb67-435e-e3f6-08ded719599c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|10070799003|376014|11063799006|56012099006|4143699003|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	e46GG1iTNdGU7UAyHv+YzEmeIMkFbcPIjwBkvG2YKCN3xxvl/86EuFZx+PEbGmzcakxkUKyu3GqCYYHfK8F4loHYLR7BSFcs6C7ltHo4QlR9LUjtLdcAcjLBU7r97mQADyUjqQwfC367gtuuaT5Pv2uTqG0+0eNYdPPHNCn0OnOWNBNktP8iW9Cvy7Su7uzD747CmxHdQNqhHvm1EiQR/Sao0VfbNpdIeuy0+8IgOiKG2ikUbPdKZnqz/tIURkXaiqd6WH6GmfyXL5TI625HrVnaWV0BWwBxbHeMNTTgs7ykla31qm6thg3yRq60PylIUCdkjC/skF8m1smAmg0V062jJkgzJm3kWuo2dgKi3YvZho1vus0RKScnXHhS3MY7VAHDB8pjMF6VjlD6mYYELKoeOU9g89ttGi13xAYEZ51rjsFsSC/o+6aKD9A1BCPqJG9KdJNKIWct4Z9ezrWW5kWTb2x09uaIsCtWXEj2qwltjfLx5WlCdi0S6Jjyrwea/om1OPZQ9Wveu2CNBohdUomqJ4+Sr9rxFNWwshQNnA2+MU1eOAeFs2rmTD6GwBoGkGcPKR5Iy93BHrfWC9kcC6SB7KGTIAzVCVTwoIwrSdA2Kgedt2W7LZJVU41qJpVfzug6ngUoy4p/YrlPlIy+VQ179tdf/VK9DP8q/51YVn8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(10070799003)(376014)(11063799006)(56012099006)(4143699003)(3023799007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFVtYVdtVXIxci83Y0NLa1Ywb01OTkdLVXZCeFZtaExmVlhRSjkyeS80V3Bv?=
 =?utf-8?B?VlpmSWlxdVhnY2sxSmNRQ0hVQmErVjRvK0N4clM1VitDdDZYVVZsc2xseTh1?=
 =?utf-8?B?U2IxOTUwNFBROHFxWUJkRG00NTkvaWoyQXFBbUc0aWZJeHIyZlUveG5DZDJJ?=
 =?utf-8?B?SFowTjZZeDYzSmFGdGF2UXlrM2tZVHZONWlrZFh2QndsYVpiQW0vRmh6cU5v?=
 =?utf-8?B?QWphUld5b1gyS20zU2ptTVRmakZ0dENhbkRyY1N3WG5rajdWaVd1WE1qMEJV?=
 =?utf-8?B?NERqc0plZFU2TmZFejdFWGFYdWZtTHg3RWF2RkZWTzZTaXRJMUV4NWlqdUhB?=
 =?utf-8?B?MHVMTkJiWWQ4eldmMXlDQWl1TTRUQTVIUXo0MXZLNkNuRXBCUG0ydUhkZ0dk?=
 =?utf-8?B?RjZhMU5FZ2VYTzJmYTFpZnY4WjVPOFNlOWNidE1kS0ZiTk1oeXB2TUtwbktR?=
 =?utf-8?B?cWpGY2tqS2JUNlUrVlcySTA5YmhObUUyTUxIMm9lajdjV1ZkcjhwL2NJN25n?=
 =?utf-8?B?d0ROT3EwWDFVUGE3NzhDbS9jVmp1NkJXSlhjUzJCaG5tcVpXMFBVSDRvNmdv?=
 =?utf-8?B?TU9hK1VrY2tIMElUTzJPZEdaYitpVXpUdDJmU3JlMEJybDFiV25lSzlOK2M1?=
 =?utf-8?B?OWM0cm4rV2JzditEN3RXRENvYlg5dFo3dlVzYmtia09jRFYxV2trNkJKMEJk?=
 =?utf-8?B?eCtzYytJOURWZDNNZXpTVkpMU1UwamtTSTU3c3lCZ1RkR1cxOHZjejE4UUYw?=
 =?utf-8?B?dElkdTlUK3QyRnVWZnhuZmdRcFBYUGR2eWFiOFlMYXZwRFVFeTV3eEpjeHFo?=
 =?utf-8?B?RmpTUE1aWlV1Vy9ZdEJCVjAxQW53SEtnYmM3cENzZ0xrNDZLUDlUNHE2YzFG?=
 =?utf-8?B?dUdVTUVrTDEyUEJHMmJmemMyS2dJc3pwRFhkcEdJQUNYekJIQXhYWnNZdmRy?=
 =?utf-8?B?ZHpkdkQ4aEhjcGptSWVCam4wZFNrQ2RvRHIrRVFRcWFXV2YwWC9EdldiQ3Z2?=
 =?utf-8?B?QmZKR3MrVHRpR3RWd0JEM1RTVlpoM3N4em9zM1FkNGE3eVZtdGpkNW1QaEhs?=
 =?utf-8?B?dFFoMjBic2JEMzBTYlNKdFZYeDRmbnowOW9QQys4cVFlQmJmbEZDWHVNS0d0?=
 =?utf-8?B?OVF5ZjViK0QrNW5oNmtrUklLbHN1Ym1teHQxWEZta0NJRmZVdzFGWG5Remxp?=
 =?utf-8?B?TzRFY1dCeTVGQnlLZFBGcU1PODFabVJBYW5nSWhjbFBHcnYrZS9kWHpaazRJ?=
 =?utf-8?B?ZHYvWDNPRDZjK2VYV2VzMzZubjBiUzFjTGxmeE5WRmdIZkJzVDdaNmJWTE5l?=
 =?utf-8?B?MFpHVStBei9JMThvZ2NjenRxMldNMC92SFA0b0tWekpSc1ZjdFFCYURNRlFp?=
 =?utf-8?B?QWZwc2k5MURzZ1lqbHc5YThEVThqYXRUWk01RWJNT0RaVHExd3pEOFhsbUcr?=
 =?utf-8?B?ajZiMFF2S01IcjkwZFJjbWJtTGM1WU5KeWdzNXpCMGRINkNsaGZlS3R3UEp1?=
 =?utf-8?B?c0QvV3RHR3JnQW5kaHdCTk1BNVRRMEtnWE5wMVdvVzZqcSttZlY5UE4yMy9V?=
 =?utf-8?B?dGN3MDY1NGN3ajNUN1JRYkxDT1cxa1gwT0Z4K2loTEE3T293bXZPbTFzc2tV?=
 =?utf-8?B?Qm93NmlvdnZ4eHdHK211YWt4bHZjckJVWi9ld2V5TG5PWS9ubThXMGlkaFFB?=
 =?utf-8?B?WnZUY1VodTk2ZVZCaUlPaURNdE5TMVpLOFBRcE11MjRZWjBjTThDYmNjZDJ2?=
 =?utf-8?B?V2V0SWU3eVJOOUU5NkZnaUxmQ1RGMU1sM2Ixc0VMMTZpckMza2xFMXBrTlBv?=
 =?utf-8?B?NjQ0UTBjRzZXQ2pYSVMxREkwZUEwcjhyaThrcUNzVVJNRlpBbkl0bjZieXNP?=
 =?utf-8?B?RVd6NEd1M1NlMTlHNmFQMEVZUzBtcjlsejYybDJadkhwdTBQRXpOSEhicjBo?=
 =?utf-8?B?dmFSU3ZYRGdBRjR4bFJndE9VTk82aFRFUmlRZVByZUtSUzFOZG1TOHlRWDJX?=
 =?utf-8?B?blAxZGpna2lRQ2MxNEl3dnloMExVOVlmT3VZU0xlZ2hWcmg5alJBSU1QelZS?=
 =?utf-8?B?S3BsQkpkRENmV1NmZFVhb1hnWmJKb1NwTElOdjZBVkQyVjZwQVEzODMyVjJC?=
 =?utf-8?B?RXRiQmtQL1ZlVHNReU5kRTc4VzlMWkNzTm1tY1BHSExMZ21kRk9janVraVhQ?=
 =?utf-8?B?L2tWS2lZZHRNdm9aL0V3VGc5dWhaeEFhV1IrcXEwY2YrRlJkMjgyQmMwRVcx?=
 =?utf-8?B?bVZwQ1J6QTZHQ1llclQyRkw3N25DR3dnR1JKN2dxRzBtWmFPeGNuTTNmNFVo?=
 =?utf-8?B?MmRWOGY3Q2FnQ2QvQzJRS0NHdmpLcVZUU2prTUxQMWdKKzgzQzBZaUgyajdY?=
 =?utf-8?Q?LSMGImWR7/3UQIOhhT7sIuKjjlPL4R/rT5NjtTMVhm/5s?=
X-MS-Exchange-AntiSpam-MessageData-1: h7PFK5XLvSjYlw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e7f335b-eb67-435e-e3f6-08ded719599c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 02:35:01.3075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hpn1Meua8RjGPCMyUGwBVWuyW+PJwabIkO8JIw2R9P5Ar7MpVzM7o+ezDyT+Mi+leUHSuyAjJ2Eg6v41qpcVxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5594
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9495-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jonathanh@nvidia.com,m:ukleinek@kernel.org,m:thierry.reding@gmail.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:linux-pwm@vger.kernel.org,m:linux-tegra@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:treding@nvidia.com,m:yiweiw@nvidia.com,m:thierryreding@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,nvidia.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 698F16E9441

On Wednesday, July 1, 2026 2:39=E2=80=AFAM Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Tue, Jun 30, 2026 at 02:54:51PM +0100, Jon Hunter wrote:
> > On 02/06/2026 10:16, Jon Hunter wrote:
> > >=20
> > > On 29/05/2026 03:47, Mikko Perttunen wrote:
> > > > Hello,
> > > >=20
> > > > this adds support for the PWM controller on Tegra264. The controlle=
r
> > > > is similar to previous generations, but the register fields are
> > > > widened, the depth is made configurable, and the enable bit moves
> > > > to a different spot.
> > > >=20
> > > > This series adds only basic support with fixed depth -- configurabl=
e
> > > > depth will come later.
> > > >=20
> > > > Patch 1 adds device tree bindings for Tegra264 PWM (compatible
> > > >    string).
> > > >=20
> > > > Patch 2 prefixes driver-local macros and static helpers with
> > > >    tegra_/TEGRA_ to make their scoping clear.
> > > >=20
> > > > Patches 3 to 6 contain the PWM driver changes for Tegra264.
> > > >=20
> > > > Patch 7 adds device tree nodes for the PWM controllers on Tegra264.
> > >=20
> > > ...
> > >=20
> > > > Mikko Perttunen (4):
> > > >        pwm: tegra: Prefix driver-local macros and functions
> > > >        pwm: tegra: Modify read/write accessors for multi-register c=
hannel
> > > >        pwm: tegra: Parametrize duty and scale field widths
> > > >        pwm: tegra: Add support for Tegra264
> > > >=20
> > > > Thierry Reding (2):
> > > >        dt-bindings: pwm: Document Tegra264 controller
> > > >        arm64: tegra: Add PWM controllers on Tegra264
> > > >=20
> > > > Yi-Wei Wang (1):
> > > >        pwm: tegra: Avoid hard-coded max clock frequency
> > > >=20
> > > >   .../bindings/pwm/nvidia,tegra20-pwm.yaml           |   1 +
> > > >   arch/arm64/boot/dts/nvidia/tegra264.dtsi           |  72 ++++++++=
++
> > > >   drivers/pwm/pwm-tegra.c                            | 155
> > > > +++++++++++ +++-------
> > > >   3 files changed, 176 insertions(+), 52 deletions(-)
> > >=20
> > >=20
> > > For the series ...
> > >=20
> > > Tested-by: Jon Hunter <jonathanh@nvidia.com>
> > > Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> > >=20
> > > Uwe, if you are OK with the version, we would like to get this into -=
next.
> >=20
> > This still applies fine on next-20260629 and so unless you have any
> > objections could we get this into -next?
>=20
> I dropped this patch series from my queue due to sashiko's replies. I
> just notice these were not sent to the linux-pwm list, otherwise I would
> have mentioned it. :-(

Sashiko replies are not sent to linux-tegra either, so I tend to miss
them. E-mail is hard :(

>=20
> So check on either
>=20
> 	https://lore.kernel.org/all/add09636-7b0e-4a99-8503-d98a75c14f4c@nvidia.=
com/
>=20
> or
>=20
> 	https://sashiko.dev/#/patchset/20260529-t264-pwm-v5-0-7bf9e405a96a%40nvi=
dia.com
>=20
> .
>=20
> I only invested a quick glance, but the feedback seems relevant. If you
> don't agree, please point out why it's wrong/irrelevant.
>=20
> Best regards
> Uwe

Sashiko:
> Does setting the target frequency to ULONG_MAX work safely with OPP
> tables?

This is not a concern. The OPP tables are designed with top OPP at the
maximum clock frequency. Indeed, before this patch, the hardcoded max
frequency in the driver matches what ULONG_MAX gets rounded to so
there is no change in functionality.

Sashiko:
> Is it possible for pc->clk_rate to be less than 256 here?

I.e. is it possible for clk_get_rate to return 0 after we have
successfully requested a rate of ULONG_MAX. I suppose that's technically
possible -- maybe if the clock is virtualized and read-only and left
disabled by boot? I can add a sanity check for clk_rate =3D=3D 0, though
we'll just have to fail the probe in that case, but at least it avoids a
division by zero.

Sashiko:
> Could this cause a regression where the PWM output is left in a
> broken state if the hardware resets the DEPTH field to 0?

The hardware reset value for the field is 256, so that is not the case.

The other item is a pre-existing issue. Worth fixing, but not
necessarily in the purview of this feature.

I can respin to add the clk_rate =3D=3D 0 check.

Cheers
Mikko



