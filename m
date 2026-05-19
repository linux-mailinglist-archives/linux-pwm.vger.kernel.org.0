Return-Path: <linux-pwm+bounces-9024-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGT1INqUDGp1jAUAu9opvQ
	(envelope-from <linux-pwm+bounces-9024-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 18:50:34 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CF0582A41
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 18:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B27EB305A8A4
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 16:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD3E407CFE;
	Tue, 19 May 2026 16:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="OJUX/sMs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021084.outbound.protection.outlook.com [52.101.100.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021A7407CD6;
	Tue, 19 May 2026 16:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779207876; cv=fail; b=O3jgy8ShzI8W1hNDVlkRBPkhmouo7XEkw8GWKlSPJ2wzce3XkwNbL77Ds0fPa49QhZe+mO1hEP/YdaqeMZGAfqVxZI+uU1Uvx1qmaEo53+YL+j/S6ebOagTwz/dXgYiTVRfE9xIOP9XaXqof2HCuU9h52QeO41jJJPeYntBX9dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779207876; c=relaxed/simple;
	bh=yiuf/jKfnFRDvrtX7ljfX0Op5w6HQ1fANBzcRvT5jMM=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=nhIgd4Eig6RPwmM1wPaiJpAeZVLyc5MqgjXYdy+smVxwooHX+1Kh4fwGGJI3C7YyAYiTO/Vo0O5L6PF0YB1mo2O77KPcTLIYSzSu1Y1v466olLjKaBOeSVwq3tyZ5K+LbE0n5S7eG45UFYIoy1VUe3PsgRwwHpDe5hAB9tK6pxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=OJUX/sMs; arc=fail smtp.client-ip=52.101.100.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CUW/L1l48koEHgXdEa4Io0kOB61/D22HWzEj3bF0qi/C22/ohJQeRoMyQFJwg3Bqriz43L7SujrxY65WACKYBpEvoe+PYG1bD0x5MLnDKtSQ7vqcUA/dfBr+NNTOB21+x3/nBpZbU8qht0nuNaJhD2512Q34DeWT2NYq3fk0+3NtNsbuHqwpcbR+4DrD+G3uebM7JwpFjJV1QbrponBQGBnisnCsinTJl6oNwjgI/U5Ff3csuKbTTP51g8wVghLwIJoAy+Q0ra8jCsYaCReqk6GkdsvAUCHyJRqpwmJbtbX5h0wPoesP3wfIsdNYMkoMAk5qwxmG82aeAPhYPY/8bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4n0Ppc59UVLV2lOxTeMwlmuzWjJzB4g59Q378/lIuo8=;
 b=DAWuvwf56xRdktGxgPm6b1R2LO1RO2ypqaRriCRDdrmeH7GUbo+xyq9PtlMj7HE5ZZLVKkFECOQNG/dTo40Td5E7v3U+8l3NZy77YXVBxYse/evmR4/0YKQCEGoUZZVeOPp2k2HTn5T7sQ8XrKL/T/4mUE3mUQACh1G/npTfuSX7uUk3NY7wD2FvhQVevb56DbI+q/G8X4IHRS68Iq6ElxX1rcKQg16Tqjh9NHN9OKzU6YpcVeXyMyKXL3A+avPcyV9TLarEuB/8eCC3g8NJrwTld6kyBpK0MxtPCRR9mVEwbVKd0vEODKq7EeVbB0QPil+1msDaYWOsfMJyrFsF8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4n0Ppc59UVLV2lOxTeMwlmuzWjJzB4g59Q378/lIuo8=;
 b=OJUX/sMsuVRSAw1aqp3B5Rgv1gw0w1FK+uab6Z42VIDrQQC28J/mX2uxqyss3UTzQ67PcymuNRZA7S2I62Z7h0mhHlNf+WmbHgp0LovxRm5gVR//fMyBb27ISPiGBnE2KFD5wiKism34JNYYW/X4T8yy1Ud75YXkCl0CpXKVSpw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO4P265MB7048.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:34f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.25; Tue, 19 May
 2026 16:24:30 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 16:24:30 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 17:24:29 +0100
Message-Id: <DIMSJVKTYX6D.AEN6OPPC2898@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 19/27] rust: pci: make Bar lifetime-parameterized
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <acourbot@nvidia.com>, <aliceryhl@google.com>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <viresh.kumar@linaro.org>, <m.wilczynski@samsung.com>,
 <ukleinek@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>
X-Mailer: aerc 0.21.0
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-20-dakr@kernel.org>
In-Reply-To: <20260517000149.3226762-20-dakr@kernel.org>
X-ClientProxiedBy: LO4P123CA0044.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::13) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO4P265MB7048:EE_
X-MS-Office365-Filtering-Correlation-Id: 20d6c432-af9b-449e-d4c3-08deb5c31a8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|921020|4143699003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Ccq8SqHCmTAieOshrmp603RjehDjXS/CrSqqvGNAOAHg+Sk49TCjdQHiNHCP65HQa/23lUEfUrH8sPWsorNY2f/33LtzO7I0r3GMImcgt9w8eA0xkF6PRPD1AkFfguPrjUzczbpKKzhK09JLxQo1QxjImzqPRZvrbRffkbxH+R9un+Mw4LMe9Ql3427MI1zB6mZcXOyeDO70L/yrzgb8tM//mhl2JELFcUjfkex4a6RIWMtiP+Ml0XRKtXucHiWVn/BseEqPREXe+jQJ1Wakyppo+FecdcVDCLb7toJS3JLI49j4b5SjM1byaLCvOt88ais+IT6SldBJIenFcz/em5oDav1QgHzEZso+D5GyZA8xHL84LLedzRad2nz2CikeQyon2dfRJW4OJMEK9CU9/C0wvGyHhTzb5QJLL6CN8eoB6a6Kv+b9yltXm5O52tRzl9QpOAFtPw5lB4EMUdstalooJ0qv/xsd+Iq0oOllntJW3uMedsiL5Z9I9A9O64kfLpHv/gWxzkciS2jOwIKGZvma6lCOdKd7dwlNOtok5fKGlIcpsw70WO1TvmoHcg9P+jVWalP3Uyn+wtY3IRosvMYQUcdrSjLbbiQRfu1S7C9BhDnIR9dq+8BsK4YOlhojQc9CjqjC+JTn7xdsSi/6i6n+N2sl/N2yxAx1MCrzlaQcKh4WR2oelFl+WaXfhtSyGwAk7mfgdpW2bK0xXQZ3Q//FecZPE+16Nn0kXV69hdc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(921020)(4143699003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vm4xWEdOaUk5YlFPMjNXd3RocmZQclVIOUQ1TXZxRGgvdXozb2M4UHI4S2g0?=
 =?utf-8?B?Mmp2VGtUME10a3FrVVJGcW1jVFBocVVvODZoNzJwdVBNa2x6c3RlZ21rYVg0?=
 =?utf-8?B?NlFKRjNRQU5PZzVJSnhxT1hMcG16ajBGVUZSRTN6WnAySlR6N215ZHVGRk5P?=
 =?utf-8?B?cDlBcVdjSDkxM2pwdmdUR1dQNkxJZ2Y1OW1CWW9FTmxRMisxMENvQ3IyMlQ4?=
 =?utf-8?B?a210SWJCYlU5U2hwdFZjcCtIUHBjMDhaaUlPMTljSy9QV2hyR012R0RNeWZ3?=
 =?utf-8?B?dXAvZDJqY3loVGpRY3ZUbHlWZFNQQ0hzTU5LdVBrM01lbU1zVHFaVk9COTVn?=
 =?utf-8?B?WTY1T2FHbGpyRS9lYmJJeklYbTA3eTk1eXpqaEIvNC8rK0NJNVVpVVE0MG10?=
 =?utf-8?B?Q0VWMUZ4NVp0clFKYUlZT1dHaVQ5Vi9uYkU5bm9mL3JrNndRTDBwMWNqTnBF?=
 =?utf-8?B?WWcrWW9ISG52b0ZTSFVGWDZNN2Evd0ZjUngwVmR4Q3VHUDNTL1RybTF2UTVO?=
 =?utf-8?B?bEhBWHZrTVUvOVA1c2NHMmhQVk91NmllMmhOWCsxNFhMZU1ZVGNtTzFYSVMy?=
 =?utf-8?B?QlNBV205OU5hL0xxQmRiNFhxQ25IdHJEUS9wM05FU2h5SVFaVzlHK005YjhV?=
 =?utf-8?B?bDhud1RBZHFORFRwamhsYXdleHlxcjNjZ3pYa2wxU211bXpvb3R2SjdMR2Ra?=
 =?utf-8?B?cTRXekZHbU5GVDB5c25jbUFPNG83ektQR3YrdjRjMi9XU2FYZWxqeEhRTmJH?=
 =?utf-8?B?VFFRbW1GSVR2cThHTlZLNmhudTlwbW5hbndUMC9YeGE0aVBGc2tWZWRNZWlS?=
 =?utf-8?B?T0dnb2RSdis4dWJxenlqek1iRVFOZmlwMWZ2Y1FmMDBTbDF6MzR3dEdpRlNE?=
 =?utf-8?B?ajB5UkxLUG9QdFJ1Zjk4U0lTbXQwQS9MR09LT3hWSnlkZkYyMXMrZmxrT1Z2?=
 =?utf-8?B?Vzhmc2N6dythZTFpRFcrMGtqeEd2S1pEWXJVUnp3WmJXcWZZQ0E3Zm9McDRz?=
 =?utf-8?B?R29pcENWbEpyMmFBV1ZoSnE2d2hBQzRMQWoweEJEUU9yejdDTmw4cjVsYlc2?=
 =?utf-8?B?RUQrR3ZpKzBYd0JmM1RpREhlcGN1NmpsdW5Cb09BT3gvcnZnWEY0bGhLMXhv?=
 =?utf-8?B?M3NlWlJuaklUeXYrUUg2Sll2TGZMYXZtSUlDTVRkdWl6UjdEMVM2LzNhMElI?=
 =?utf-8?B?QjRUcTluaWx6aTVsTDlYL09xeHMxaXoyYmR5Z1d4VnoySU5DWU5USFI3RlNK?=
 =?utf-8?B?NjI5VkMvWXNvdm5xUFI1cnVPYUVKN0lxM2tMWDVyNk9vMWllS210R00zczVh?=
 =?utf-8?B?RVVNWG52dWVxNXNVSVFDNjZyVTdzTks3L1JEcDA0NzJkNkwxRjN2QzV4WjNH?=
 =?utf-8?B?YzErZTJvdlMzb0NZWjdUanJtTkM2dityTDVYQ0Z4WXQwbGVRbjNWbTlBMXps?=
 =?utf-8?B?WEg3MHc5V2xrMmJjR0s2bnl3MkRiUndrcUUvUEZ2OFQ5d0xFMC8vWlRyWkVr?=
 =?utf-8?B?K0VhSSszcFJISzllLzdxaWJKTG8rbEd2bStoZGtKalZUN1JpTDNQcHJxSFJ4?=
 =?utf-8?B?UjQvNmRKWis4VyttZGllMVV1QWxPcExEV3gxMXYyWnNXcUxiaVZRcnBDMm13?=
 =?utf-8?B?N3BWcFVSMjA2QnhpQzdYcFRPWUh5N1ErbEVYVDBmcHBFbFlKcVk2NGI3OXA3?=
 =?utf-8?B?NjBPUmpyODM5a2ZQTmJocDJQbjh2bE5IbTA1QmpmWU9aNUc3aFlIQnhaQUdu?=
 =?utf-8?B?L0pQcFBkZXA4NkZPKzN1K0dIVHdyODEvSHVOMCtGRk1zWjZXK3BZMiszSlVa?=
 =?utf-8?B?TTUwNU92ZUREZm9CSVV3Ymd0aHdjVHJXYzlPbkgvYlU3YUp3eENxdGhKM1BU?=
 =?utf-8?B?SFlpVnFYdC9Gd2krTTE3cmJFZkN4Nm5iTWNHaWJlM2lSa1kxSkNLUUgwak1R?=
 =?utf-8?B?bEQwa0ZYa3E2dWJFSG5pYndpY2FCYVFSWTluTGVzNEdvUkFWS05la01sRDYr?=
 =?utf-8?B?RStSbDQ1SmVNdHVoY3NNcTdKbXA3ZHFDOEViTWhxenVOL3J1NlowMUYzZWE1?=
 =?utf-8?B?bXB5TDJ1amJRVENmNWdkamhDOURxT0lDaVVkZnBxNzNqdDhtZ3FTUGZKM2w5?=
 =?utf-8?B?clJFeUZmZUsrZjM4UTJPVGNHbUJSNXRQa3FCdWhlaXJiMEg1OTViRXpvUmlG?=
 =?utf-8?B?cWhTYkdtMXVnWkNoeDg5WmI3RmswK09PVU9ZMWRaTWM2aHVaeDRtc1ZYZFJT?=
 =?utf-8?B?anNUSmdiWGNxVXY5Qm92eHJldkVZL25ianMzeDdaQjhoTDhJVnYwVlVpQWJR?=
 =?utf-8?B?QSt0KzhVaHBKT2grSlpRcmdvdENtazhaVEY1cjh5dFNQWkdrR1NzZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d6c432-af9b-449e-d4c3-08deb5c31a8e
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 16:24:30.3107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QiktDB/k5TkULECU9WY9BMHAL7dVdV8wIYiORfUYgBbUyZAkToziXsFmiOFdidv/AuAEhxYLJTZFznagZ0AWhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB7048
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9024-lists,linux-pwm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[garyguo.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,garyguo.net:mid,garyguo.net:dkim]
X-Rspamd-Queue-Id: 03CF0582A41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun May 17, 2026 at 1:01 AM BST, Danilo Krummrich wrote:
> Convert pci::Bar<SIZE> to pci::Bar<'bound, SIZE>, storing &'bound
> Device<Bound> to tie the BAR mapping lifetime to the device.
>
> iomap_region_sized() now returns Result<Bar<'bound, SIZE>> directly inste=
ad
> of impl PinInit<Devres<Bar<SIZE>>, Error>.
>
> Add Bar::into_devres() to consume the bar and register it as a
> device-managed resource, returning Devres<Bar<'static, SIZE>>. The
> lifetime is erased to 'static because Devres guarantees the bar does not
> actually outlive the device -- access is revoked on unbind.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  drivers/gpu/nova-core/driver.rs |  7 ++--
>  rust/kernel/devres.rs           |  2 +-
>  rust/kernel/pci/io.rs           | 68 +++++++++++++++++----------------
>  samples/rust/rust_driver_pci.rs |  5 ++-
>  4 files changed, 44 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driv=
er.rs
> index ab0d7f2b516c..3f6d8cedf5ab 100644
> --- a/drivers/gpu/nova-core/driver.rs
> +++ b/drivers/gpu/nova-core/driver.rs
> @@ -47,7 +47,7 @@ pub(crate) struct NovaCore {
>  // DMA addresses. These systems should be quite rare.
>  const GPU_DMA_BITS: u32 =3D 47;
> =20
> -pub(crate) type Bar0 =3D pci::Bar<BAR0_SIZE>;
> +pub(crate) type Bar0 =3D pci::Bar<'static, BAR0_SIZE>;
> =20
>  kernel::pci_device_table!(
>      PCI_TABLE,
> @@ -94,8 +94,9 @@ fn probe<'bound>(
>              // other threads of execution.
>              unsafe { pdev.dma_set_mask_and_coherent(DmaMask::new::<GPU_D=
MA_BITS>())? };
> =20
> -            let bar =3D Arc::pin_init(
> -                pdev.iomap_region_sized::<BAR0_SIZE>(0, c"nova-core/bar0=
"),
> +            let bar =3D Arc::new(
> +                pdev.iomap_region_sized::<BAR0_SIZE>(0, c"nova-core/bar0=
")?
> +                    .into_devres()?,
>                  GFP_KERNEL,
>              )?;
> =20
> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> index 9e5f93aed20c..ec63317665f4 100644
> --- a/rust/kernel/devres.rs
> +++ b/rust/kernel/devres.rs
> @@ -304,7 +304,7 @@ pub fn device(&self) -> &Device {
>      ///     pci, //
>      /// };
>      ///
> -    /// fn from_core(dev: &pci::Device<Core>, devres: Devres<pci::Bar<0x=
4>>) -> Result {
> +    /// fn from_core(dev: &pci::Device<Core>, devres: Devres<pci::Bar<'_=
, 0x4>>) -> Result {
>      ///     let bar =3D devres.access(dev.as_ref())?;
>      ///
>      ///     let _ =3D bar.read32(0x0);
> diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
> index ae78676c927f..5668394a155b 100644
> --- a/rust/kernel/pci/io.rs
> +++ b/rust/kernel/pci/io.rs
> @@ -14,8 +14,7 @@
>          Mmio,
>          MmioRaw, //
>      },
> -    prelude::*,
> -    sync::aref::ARef, //
> +    prelude::*, //
>  };
>  use core::{
>      marker::PhantomData,
> @@ -78,15 +77,15 @@ impl ConfigSpaceKind for Extended {
>  /// The generic parameter `S` indicates the maximum size of the configur=
ation space.
>  /// Use [`Normal`] for 256-byte legacy configuration space or [`Extended=
`] for
>  /// 4096-byte PCIe extended configuration space (default).
> -pub struct ConfigSpace<'a, S: ConfigSpaceKind =3D Extended> {
> -    pub(crate) pdev: &'a Device<device::Bound>,
> +pub struct ConfigSpace<'bound, S: ConfigSpaceKind =3D Extended> {
> +    pub(crate) pdev: &'bound Device<device::Bound>,
>      _marker: PhantomData<S>,
>  }
> =20
>  /// Implements [`IoCapable`] on [`ConfigSpace`] for `$ty` using `$read_f=
n` and `$write_fn`.
>  macro_rules! impl_config_space_io_capable {
>      ($ty:ty, $read_fn:ident, $write_fn:ident) =3D> {
> -        impl<'a, S: ConfigSpaceKind> IoCapable<$ty> for ConfigSpace<'a, =
S> {
> +        impl<'bound, S: ConfigSpaceKind> IoCapable<$ty> for ConfigSpace<=
'bound, S> {
>              unsafe fn io_read(&self, address: usize) -> $ty {
>                  let mut val: $ty =3D 0;
> =20
> @@ -119,7 +118,7 @@ unsafe fn io_write(&self, value: $ty, address: usize)=
 {
>  impl_config_space_io_capable!(u16, pci_read_config_word, pci_write_confi=
g_word);
>  impl_config_space_io_capable!(u32, pci_read_config_dword, pci_write_conf=
ig_dword);
> =20
> -impl<'a, S: ConfigSpaceKind> Io for ConfigSpace<'a, S> {
> +impl<'bound, S: ConfigSpaceKind> Io for ConfigSpace<'bound, S> {
>      /// Returns the base address of the I/O region. It is always 0 for c=
onfiguration space.
>      #[inline]
>      fn addr(&self) -> usize {
> @@ -133,7 +132,7 @@ fn maxsize(&self) -> usize {
>      }
>  }
> =20
> -impl<'a, S: ConfigSpaceKind> IoKnownSize for ConfigSpace<'a, S> {
> +impl<'bound, S: ConfigSpaceKind> IoKnownSize for ConfigSpace<'bound, S> =
{
>      const MIN_SIZE: usize =3D S::SIZE;
>  }
> =20
> @@ -146,14 +145,14 @@ impl<'a, S: ConfigSpaceKind> IoKnownSize for Config=
Space<'a, S> {
>  ///
>  /// `Bar` always holds an `IoRaw` instance that holds a valid pointer to=
 the start of the I/O
>  /// memory mapped PCI BAR and its size.
> -pub struct Bar<const SIZE: usize =3D 0> {
> -    pdev: ARef<Device>,
> +pub struct Bar<'bound, const SIZE: usize =3D 0> {
> +    pdev: &'bound Device<device::Bound>,

I think there's probably no need to name this `'bound`. From an individual
resource's perspective, there is no need to ensure that the lifetime is liv=
ing
as long as a bound device.

It is perfectly fine to temporarily obtain a `Bar` and just destroy it befo=
re
device is unbound. So in some sense, this is

    struct Bar<'a, const SIZE: usize> where 'bound: 'a

and this bound is implied by the `&'a Device<device::Bound>` type.

For interfaces which currently require invariance (e.g. `Driver::Data<'boun=
d>`),
the name change is more important because the API does require a matching
lifetime (and also DevResLt).

>      io: MmioRaw<SIZE>,
>      num: i32,
>  }
> =20
> -impl<const SIZE: usize> Bar<SIZE> {
> -    pub(super) fn new(pdev: &Device, num: u32, name: &CStr) -> Result<Se=
lf> {
> +impl<'bound, const SIZE: usize> Bar<'bound, SIZE> {
> +    pub(super) fn new(pdev: &'bound Device<device::Bound>, num: u32, nam=
e: &CStr) -> Result<Self> {
>          let len =3D pdev.resource_len(num)?;
>          if len =3D=3D 0 {
>              return Err(ENOMEM);
> @@ -196,11 +195,7 @@ pub(super) fn new(pdev: &Device, num: u32, name: &CS=
tr) -> Result<Self> {
>              }
>          };
> =20
> -        Ok(Bar {
> -            pdev: pdev.into(),
> -            io,
> -            num,
> -        })
> +        Ok(Bar { pdev, io, num })
>      }
> =20
>      /// # Safety
> @@ -219,11 +214,24 @@ unsafe fn do_release(pdev: &Device, ioptr: usize, n=
um: i32) {
> =20
>      fn release(&self) {
>          // SAFETY: The safety requirements are guaranteed by the type in=
variant of `self.pdev`.
> -        unsafe { Self::do_release(&self.pdev, self.io.addr(), self.num) =
};
> +        unsafe { Self::do_release(self.pdev, self.io.addr(), self.num) }=
;
> +    }
> +
> +    /// Consume the `Bar` and register it as a device-managed resource.
> +    ///
> +    /// The returned `Devres<Bar<'static, SIZE>>` can outlive the origin=
al lifetime `'bound`. Access
> +    /// to the BAR is revoked when the device is unbound.
> +    pub fn into_devres(self) -> Result<Devres<Bar<'static, SIZE>>> {
> +        // SAFETY: Casting to `'static` is sound because `Devres` guaran=
tees the `Bar` does not
> +        // actually outlive the device -- access is revoked and the reso=
urce is released when the
> +        // device is unbound.
> +        let bar: Bar<'static, SIZE> =3D unsafe { core::mem::transmute(se=
lf) };
> +        let pdev =3D bar.pdev;
> +        Devres::new(pdev.as_ref(), bar)

One thing to note (which kinda motivates to suggest `'bound` might not be a=
 good
name) is that while this is sound for `Bar`, this logic isn't true in gener=
al
for things that with the same shape as `Bar`.

For example, say if we have

    struct MyResource<'bound> {
        dev: &'bound Device<Bound>,
        data: &'bound [u8],
    }

then it's not okay to turn this into `DevRes<MyResource<'static>>` (or
`DevResLt<ForLt!(MyResource<'_>)>`, because the user can shorten the lifeti=
me on
`&Device<Bound>`:

    fn bad_fn<'bound>(dev: &'bound Device<Bound>) -> DevRes<MyResource<'sta=
tic>> {
        let local =3D [0; 64];
        // Basically `MyResource<'local>`.
        let my_resource =3D MyResource {
            dev,
            data: &local,
        };
        my_resource.into_devres()
    }

Now this is obviously bad because the resource now outlives `local` despite=
 that
it shouldn't. The `'bound` lifetime becomes the the confusion factor here.

If this is just `&'a`, then you need to actually justify why the `into_devr=
es()`
is fine, which you still can for `Bar` not for `MyResource`.

(This also means that sound and generic API of `DevResLt` would need either=
 an
API with invariant lifetime, or with callback API. So something like

    struct BoundDevice<'bound>(&'bound Device<Bound>, PhantomData<fn(&'boun=
d ())-> &'bound ()>);

    impl BoundDevice<'bound> {
        fn into_devres<F: ForLt>(&self, value: F::Of<'bound>) -> DevResLt<F=
>;
    }

Or

    impl Device<Bound> {
        fn new_devres<F: ForLt>(&self, f: impl for<'bound> FnOnce(&'bound D=
evice<Bound>) -> F::Of<'bound>) -> DevResLt<F>;
    }

Either way, I think we probably want to limit `'bound` to cases where it's
actually `'bound` and not some possibly shortened lifetime.

Best,
Gary

>      }
>  }
> =20
> -impl Bar {
> +impl Bar<'_> {
>      #[inline]
>      pub(super) fn index_is_valid(index: u32) -> bool {
>          // A `struct pci_dev` owns an array of resources with at most `P=
CI_NUM_RESOURCES` entries.
> @@ -231,13 +239,13 @@ pub(super) fn index_is_valid(index: u32) -> bool {
>      }
>  }
> =20
> -impl<const SIZE: usize> Drop for Bar<SIZE> {
> +impl<const SIZE: usize> Drop for Bar<'_, SIZE> {
>      fn drop(&mut self) {
>          self.release();
>      }
>  }
> =20
> -impl<const SIZE: usize> Deref for Bar<SIZE> {
> +impl<const SIZE: usize> Deref for Bar<'_, SIZE> {
>      type Target =3D Mmio<SIZE>;
> =20
>      fn deref(&self) -> &Self::Target {
> @@ -249,20 +257,16 @@ fn deref(&self) -> &Self::Target {
>  impl Device<device::Bound> {
>      /// Maps an entire PCI BAR after performing a region-request on it. =
I/O operation bound checks
>      /// can be performed on compile time for offsets (plus the requested=
 type size) < SIZE.
> -    pub fn iomap_region_sized<'a, const SIZE: usize>(
> -        &'a self,
> +    pub fn iomap_region_sized<'bound, const SIZE: usize>(
> +        &'bound self,
>          bar: u32,
> -        name: &'a CStr,
> -    ) -> impl PinInit<Devres<Bar<SIZE>>, Error> + 'a {
> -        Devres::new(self.as_ref(), Bar::<SIZE>::new(self, bar, name))
> +        name: &CStr,
> +    ) -> Result<Bar<'bound, SIZE>> {
> +        Bar::new(self, bar, name)
>      }
> =20
>      /// Maps an entire PCI BAR after performing a region-request on it.
> -    pub fn iomap_region<'a>(
> -        &'a self,
> -        bar: u32,
> -        name: &'a CStr,
> -    ) -> impl PinInit<Devres<Bar>, Error> + 'a {
> +    pub fn iomap_region<'bound>(&'bound self, bar: u32, name: &CStr) -> =
Result<Bar<'bound>> {
>          self.iomap_region_sized::<0>(bar, name)
>      }
> =20
> @@ -282,7 +286,7 @@ pub fn cfg_size(&self) -> ConfigSpaceSize {
>      }
> =20
>      /// Return an initialized normal (256-byte) config space object.
> -    pub fn config_space<'a>(&'a self) -> ConfigSpace<'a, Normal> {
> +    pub fn config_space<'bound>(&'bound self) -> ConfigSpace<'bound, Nor=
mal> {
>          ConfigSpace {
>              pdev: self,
>              _marker: PhantomData,
> @@ -290,7 +294,7 @@ pub fn config_space<'a>(&'a self) -> ConfigSpace<'a, =
Normal> {
>      }
> =20
>      /// Return an initialized extended (4096-byte) config space object.
> -    pub fn config_space_extended<'a>(&'a self) -> Result<ConfigSpace<'a,=
 Extended>> {
> +    pub fn config_space_extended<'bound>(&'bound self) -> Result<ConfigS=
pace<'bound, Extended>> {
>          if self.cfg_size() !=3D ConfigSpaceSize::Extended {
>              return Err(EINVAL);
>          }
> diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_p=
ci.rs
> index 30b9311812f3..7791363df0a0 100644
> --- a/samples/rust/rust_driver_pci.rs
> +++ b/samples/rust/rust_driver_pci.rs
> @@ -45,7 +45,7 @@ mod regs {
>      pub(super) const END: usize =3D 0x10;
>  }
> =20
> -type Bar0 =3D pci::Bar<{ regs::END }>;
> +type Bar0 =3D pci::Bar<'static, { regs::END }>;
> =20
>  #[derive(Copy, Clone, Debug)]
>  struct TestIndex(u8);
> @@ -161,7 +161,8 @@ fn probe<'bound>(
>              pdev.set_master();
> =20
>              Ok(try_pin_init!(Self {
> -                bar <- pdev.iomap_region_sized::<{ regs::END }>(0, c"rus=
t_driver_pci"),
> +                bar: pdev.iomap_region_sized::<{ regs::END }>(0, c"rust_=
driver_pci")?
> +                    .into_devres()?,
>                  index: *info,
>                  _: {
>                      let bar =3D bar.access(pdev.as_ref())?;


