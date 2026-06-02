Return-Path: <linux-pwm+bounces-9222-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +L3pHvagHmquDAAAu9opvQ
	(envelope-from <linux-pwm+bounces-9222-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 02 Jun 2026 11:23:02 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E408262B5F2
	for <lists+linux-pwm@lfdr.de>; Tue, 02 Jun 2026 11:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5FEF8300FF9F
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Jun 2026 09:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8E93B6C1D;
	Tue,  2 Jun 2026 09:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KMucVYJP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011025.outbound.protection.outlook.com [40.107.208.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5359384039;
	Tue,  2 Jun 2026 09:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780391796; cv=fail; b=En2nqz3FfSNz/YSapBVsCWPyQx6/W/sWxQgBHNeJvueQyjpRXknKkZyLMKsP1MTRq2Ha5mQ9BzhkK8vBToh6+fXQMeIb46vtn4gJInyxf+hw7KYyOuIDhEeBo9x3bLQyKTCvfc11Vss7C9dTXykX9NopnynLrWGOXUGKndKuqVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780391796; c=relaxed/simple;
	bh=/rT+LV2yVgMjFgyoT69El2so9jjqukMQlFa3y2H/wPE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B1wPjCwVL23EpII7sAl9JpTIOqgn8YSNZGSFpGUELjY5lCasJ9ckd0lIfcCb+ZUUIkZhYxFpMLuPXUYy+d3ruigZY9mZJrvN9yP0FlsVwVVGHYSGhX9kaxJXccp3/kzeDCkLOta0d6XG3OAhL6Y7GFFjsJTJRYwAtot5EAmp2rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KMucVYJP; arc=fail smtp.client-ip=40.107.208.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o9AelXCX4PbyW6RFo6L5ynzEpiQIgCtWagTKX6tyyAYVA6INZXRMTgLo0+hn7OA4IPx4TeOf9mphcftB75Q8KHvP7MJ3ik9MoKwAGrlDc+0BAsb4hJ4bKRO0dScZiHBFWlMGRaWFiMhHhq+2Ut97NUBfmA5dMfGVlGddG0Q+v/a/TfV1FWeZ2VYyTxPB+nWmUdejxGyniKfmJKuVcqgYpwd6SvYqtQNKhYKEOJ4uCUXLGP+rXA1wjl94WtNnl+UTkPNQwnlv23TYOfnP2zTga0/0dawR0zKm8swYQzc64HYlCvsOoA5w4p44NJ1uw2W8TImOCqdy1JrEonQ/cFOEUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfM3AuzXpuXJ3rDVUn5a3f122nN5ihd61beXMz/VwxE=;
 b=sCOV9LXsjLFZkRb3TOJkTyfpRQHz7Zp6MYRnX7tj8Pou6UI/m99swBjk4qEjboPwoe0bpIPY0RZnX0qOkXNwolXnjfxrJRoZiPPduIpvRtR1yZKa4xsqwo9/T4Wt3mhwtn61uqftQ8Myn7lSOoSFQIzMmYsS+PYAeH7EdZNZXahYoPfN4ZQhfZi1j/Jk4JsVjGWp0vLmIVuNvimdoopj5KejorIBYEHD//0fJnpdcWR3FgABXfARuSEC9cZ9yRcRz12KQ6b66Ti4hqChmkfLnXDQhWvMJBR6WIf4NkXlLOYrCS+ezzSy/4fr+w8FhUCytLm7EdzPCHa9fYAiP10bgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfM3AuzXpuXJ3rDVUn5a3f122nN5ihd61beXMz/VwxE=;
 b=KMucVYJP19csHYpwegfXOLIV8+rdW+LA8rW7F+NmihkLuXts1mh1U4GNLgXWD3JcZ9OSohHvQOoJh0rah0vvndmBwpfC4Cthn0OcW1Xp/4d0ZjdVEQGwcmsN6Ta5jCh6mt23hD2FTNeFwn6zzLeQojanDsfyfK4JOxhekqfGJpIpwX665Zg1X+ccB8DqZcwEnbBlGMBBHFz8Xwg74VkPlm7lj+miKPRSc/Z3QJdVk11zAWrFSpA04EqhbeM96w8WRyaLXQLfiOXlXzGPxf/kt4jDd1psX0VbXEJ3JHzbVS7BSr6+eso+5ApLP/dr+20hyr43Vnjq3VlcM5Bs9pjYCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV5PR12MB9754.namprd12.prod.outlook.com (2603:10b6:408:305::12)
 by MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 09:16:32 +0000
Received: from LV5PR12MB9754.namprd12.prod.outlook.com
 ([fe80::9667:3c95:27d2:73da]) by LV5PR12MB9754.namprd12.prod.outlook.com
 ([fe80::9667:3c95:27d2:73da%7]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 09:16:31 +0000
Message-ID: <e7b0d66e-ef2f-47d8-8844-38ae63eaf7fb@nvidia.com>
Date: Tue, 2 Jun 2026 10:16:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/7] Tegra264 PWM support
To: Mikko Perttunen <mperttunen@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Thierry Reding <treding@nvidia.com>, Yi-Wei Wang <yiweiw@nvidia.com>
References: <20260529-t264-pwm-v5-0-7bf9e405a96a@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260529-t264-pwm-v5-0-7bf9e405a96a@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0238.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:372::11) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9754:EE_|MN2PR12MB4223:EE_
X-MS-Office365-Filtering-Correlation-Id: 72bbb1d1-2060-4b51-3ddb-08dec087a1fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|11063799006|18002099003|3023799007|22082099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	bAPErZqzcKmiJS/Z6nTyqaUlQOaqpj+7rlFMm7xzmASo/Qinx54iaosjm4HAcVcqJlSBkSn9dLF0Sljn61eJf1/0a8/W/iC8AhhdADpY8Pr75xVW15NLKiTYIWL9PzpE6l0iAhFN0uEIxHNwIJEz40s6pZb32OQqJR7wZV7zWDVk7YEWf1LY1zGrOSc0ZD6ROQRin80Pw1nqkdhhAUpPGfJJ+Wn+zEuzDKhvGocj1r8A1CQk5ytmC7m1lUFVWPHNM7I3rEd6279zmOtVM8G4ehoNbMkqjP24zZTZjifG0TJq+qJgXOJG8RRbdlIQ8i9ekG2nUR2RziJwV8wGhd0kq/k/QnoOoijH8h1M63HFm0OY6oKNe2DhJtwDW5y6oWJE9siHBgzfRhjU0lB81TN81ls+GX3vR7kqOo+XxA0SAVCTf7ca53gKovP5Jrjj4AXWqBkbn/2H1MV7664Cj30RLIqp1X4rimE+M3xLxYvO4ZuC0wZ/NGs7siwzMP0J3EPpCl1L+59/XiHUJSviWtd9kO2XYspvfDvcv8BHFe4K2boIpcdD+AvGACIWIk4YTrn4D9J9gGJMDUHV93sHalRZawmKGOcp+aKTDPuYXkgrVnBO29qZe5+RAvjl/xSXbFxaKx1OdUwMYoQ1HQhA7JdOZM+hkp5z2TqXa40rfRoGLvaBtx9H70FOPR6Xdkg4Ciqo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9754.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(11063799006)(18002099003)(3023799007)(22082099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHduam9HVmRtSmZDck9QM3J0OXBBVXN5dnZHRXhONGpDWHpHVEpQNnZXdkpa?=
 =?utf-8?B?SVcyWlQwUXFsTE5Ydys5ZzNoRTk3bXhqa3JyM3BZU1VvaUo4Mjl0NUM4RFIw?=
 =?utf-8?B?UkdLRzYxTURhaTA2ZnJDYU80SE5KN1ZtTnZuUXp5cStlTWdvMDJsUFNkc2po?=
 =?utf-8?B?ZDg0UTdldXc1c3FKRHZWbGpNV3c5dXc5RElnbjYvUnJNOGIrT3BqdUJaTXVX?=
 =?utf-8?B?L3R4R2lNTjZIdWh5TDMzQ1NIZlZaOEdEN3JGWTdwemtNSnQxbDZ5VE4wZFND?=
 =?utf-8?B?WmZlbXpreGpLM2FLeFpFOFJEU29GNzBSaU1zbU5kUGZwdGxRVHhpUnllYWNR?=
 =?utf-8?B?UlRNSlZJOGN6dVM1L3ZYQkNLRjI2Q0hHc2JncmpHU1FCV2g3ekpYQkc0dGp2?=
 =?utf-8?B?T2h1ekdPeEVHTmRkR3BrVnRjNzdvZEtZSVc2OUNVOWVwVzYzUVlGVW5xRUNa?=
 =?utf-8?B?U0RaVDUwSU5tMFZraFoxcVNaRldpSVhiakd2clJJc0ViWVRzYVI3ODZyQWFD?=
 =?utf-8?B?TjUxWGtyMHYxcXFNOUpWMmlwY2o0UmN5ZHc2MVNyYXdybmxyOWMrY2NER1Ri?=
 =?utf-8?B?Q293ZHUyejJ6UFc0Rm5qV3VyVFkvcFpNTEYzdi9hcm1KRkdscjluRlAzYTR1?=
 =?utf-8?B?SndBZGxaa0dPYy93Q1ZFekpnYlBHWGEydnhOS01nTGxoSFdUL3YrbS9Wc1pI?=
 =?utf-8?B?eVZHTWVxTGpHQzVZRnZMdVV2REdUazZVS2NQelVRQ1Y3WHgvRjdtYnBwVWRx?=
 =?utf-8?B?TzZNbDAvcGtqV3BMaEUwNUZvY1lzdVhad2VZNjkvR3NFQlk3OWNTNTB4VEJL?=
 =?utf-8?B?Wm5wL1pLRFpQV2tOTG83d1QyNWhVelpaWGVaK1hkTW9JOFYzSGpCSkxZWWQ4?=
 =?utf-8?B?TVZjOVY4Mi82QndlcERLcHp6azZVMW9tOUs2RytDUVVYQ25jQXNDZEc2MExC?=
 =?utf-8?B?WEdKSXYxT2dyTkE2VjRaWEFLbXh3b2wrSXFUa2w0OEZHWER0elhXdjQ3aXJY?=
 =?utf-8?B?SlRpMmJzZmhWZVFuMmNESDBYd2I0UHJ0VEFKb01qUWlBVHpBeTNERGdGbEZ6?=
 =?utf-8?B?cnV5c3lVdnRNVU1HNHJDY1ZTZ096QVhMRytMclRWbStodVBRM1VjVFYwbnZw?=
 =?utf-8?B?d1JZVmo2Sk9IU0NPT0s0VzFIQlJqbGtwNjJWMnpNZDc1S0lnZG01cHk0WC9J?=
 =?utf-8?B?N2c5WUE0MmJ3YzNnWHBJTjhqdElKQkF6d3lmd3l0VDZtYlhaK1FzSGVPcDlv?=
 =?utf-8?B?ODVjSmZZWWgzY0Q3elAvRjFUUGo1U1pIaXpPUXRGTVZoT0Z4U1VSY29qc0d3?=
 =?utf-8?B?bS83bFFMWWMydyt6N0orbkJMM0tRNlBRNjh3c1gyU3hJMXlocUNVK1ZVT1VG?=
 =?utf-8?B?OWZGSU5wbUtXZXJNQ1BRMzRRZlp1Z3N1ZFdqWHlJMlNoSzlLUCtUUks1Vkk4?=
 =?utf-8?B?Y3Y2bzIyY0p1MHZRaDJ5eTN3eXdTU0hEckxNRFh0bnByNGZ6Skl6RER0Qk5m?=
 =?utf-8?B?T0RldnlKa1YxL2tyT3dtWEJJM3VsZEpHNlFGbWdSQzRLRWxUSnNhYjN3d3h3?=
 =?utf-8?B?RVhTWnlFTTM5QVY2c21tS2l0aXM2enhEVkxGU3E5SUFUNTdDUEl1eHBCaFZF?=
 =?utf-8?B?T0RueSs3Zkl3anBCRFdVblAwS2RYYnlKc1NYWTA3LzdFN3BhTXFNRjdGditE?=
 =?utf-8?B?NkVPSE5LMk1KRVRGLzNmSGdPVW9EaGkwdm5DYThzcy82NjNhTEE0b1Uzd1BT?=
 =?utf-8?B?dThxekJaOW45UVdFZHJ2VTVIVFA5OGtLb3dZQmNQRnA4K1NkOERTWDlPR2xl?=
 =?utf-8?B?U3BsNGR3WlNheGZtb1lkV2VBSUlTRVI0YWpJbkhDUFV4MEE1c2FsMStySGFM?=
 =?utf-8?B?d1J0S3I4T016UVV6UGdpeTRTQlVMRlJicHNZMGtmOUlMRis1d1NhOEh1MVBa?=
 =?utf-8?B?WmtkQ0hQMUw0ZmJnRHZyL2ovN3dEakVMZUdYSXcrNjRIR0ViSU9JalhpdzVD?=
 =?utf-8?B?V2RiQ01yckFWRW11c2RpbmpHSzNuM3dmN3pNMy84S2dWY3NsUnphYy9maThv?=
 =?utf-8?B?ZzFxVkgwRTRxZzVFTHhhOW5xcE1waXZKcUh1VFFzNFlIQ1JGekU2bjdaaDdV?=
 =?utf-8?B?UnFqRXg3T211VHVVaFVZQnZSbndvbkNWZ1ZianNwWVA1WWQ3Nmx0WGRBNjNo?=
 =?utf-8?B?OHdPa0gyelF6M0FTSkV6REZCTS84bzEwd0dSbnVtMnI4c1pWMnRCaHpRaEhQ?=
 =?utf-8?B?Z2xHMERyUlFnRVBkQVJsQm1PWE1ycGxMYjRVYXZVRXp1eHZxb3NWNFRYT2RE?=
 =?utf-8?B?MHNXaVY0S2VBbXlsMkQyZHJVN1MrTS9FT3l6L3NXZnM1ZEZ2SWhadz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72bbb1d1-2060-4b51-3ddb-08dec087a1fc
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 09:16:31.0056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XtWNXqEdiF62DVFDP0wjsfxpwGK+CPnp94eeMATEGudk/A4zwo1sJoGDt7Hyyd3mIqyEUe+8X45ukcIJIIb6Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223
X-Rspamd-Queue-Id: E408262B5F2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9222-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[nvidia.com,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Action: no action


On 29/05/2026 03:47, Mikko Perttunen wrote:
> Hello,
> 
> this adds support for the PWM controller on Tegra264. The controller
> is similar to previous generations, but the register fields are
> widened, the depth is made configurable, and the enable bit moves
> to a different spot.
> 
> This series adds only basic support with fixed depth -- configurable
> depth will come later.
> 
> Patch 1 adds device tree bindings for Tegra264 PWM (compatible
>    string).
> 
> Patch 2 prefixes driver-local macros and static helpers with
>    tegra_/TEGRA_ to make their scoping clear.
> 
> Patches 3 to 6 contain the PWM driver changes for Tegra264.
> 
> Patch 7 adds device tree nodes for the PWM controllers on Tegra264.

...

> Mikko Perttunen (4):
>        pwm: tegra: Prefix driver-local macros and functions
>        pwm: tegra: Modify read/write accessors for multi-register channel
>        pwm: tegra: Parametrize duty and scale field widths
>        pwm: tegra: Add support for Tegra264
> 
> Thierry Reding (2):
>        dt-bindings: pwm: Document Tegra264 controller
>        arm64: tegra: Add PWM controllers on Tegra264
> 
> Yi-Wei Wang (1):
>        pwm: tegra: Avoid hard-coded max clock frequency
> 
>   .../bindings/pwm/nvidia,tegra20-pwm.yaml           |   1 +
>   arch/arm64/boot/dts/nvidia/tegra264.dtsi           |  72 ++++++++++
>   drivers/pwm/pwm-tegra.c                            | 155 ++++++++++++++-------
>   3 files changed, 176 insertions(+), 52 deletions(-)


For the series ...

Tested-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Uwe, if you are OK with the version, we would like to get this into -next.

Thanks!
Jon

-- 
nvpublic


