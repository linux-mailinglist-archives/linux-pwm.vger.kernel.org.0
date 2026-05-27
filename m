Return-Path: <linux-pwm+bounces-9169-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DXwI1zxFmpcxwcAu9opvQ
	(envelope-from <linux-pwm+bounces-9169-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 15:27:56 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5229D5E4F3F
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 15:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 697AD308AD70
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 13:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C4340C5CF;
	Wed, 27 May 2026 13:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="yv+LFrVi"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020115.outbound.protection.outlook.com [52.101.195.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03201409601;
	Wed, 27 May 2026 13:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779888138; cv=fail; b=eC0nZ9h/+XNtXwsBWaObEQPs3WqILhuzy/T/bmoIF4d4koUP5/udu0m1xP/mQFhdSOhMscGEn7rp2IijQ/hmKHyILeEfGeAmevUps3eTl2tA+pFRQ45KO0l8QQ1ZjO7KUPr9HLKYKT3KaTChj9avD8oDw12NBSmmpcz8llUOXwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779888138; c=relaxed/simple;
	bh=bvFyY5brjyqfYobdoBlijclDBfJ5DTfOd4Wyg3anoSY=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=ZYmcZMe/aBCObI0AwAZzv412ekrJMzk7JZboz1VZGrD9PrDE1VVx+Drkb4ggl/mBZSPh/Ox53BXkaa8ZSG52Ue31HMDC6UMghgcWEYt3YUtTTSriHYcBedceYCVZ4DvlQ8+JXi1aB4gVakMEDTYkvwZ10fPupRf8md0/WNkbuvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=yv+LFrVi; arc=fail smtp.client-ip=52.101.195.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HhxktwYmB/HKtfRC8q5Tuqy0UVQIsp9fLGuOS3mHgzOVV6Ub8v3eT2cKdrIWAhJOMrC8+2rfBn9R2C4aKql6Wlghkf5YWt6M0H7z1tXJP9ZW9e8yKILaMuaD0Z8UvYjuLOlqERA/otV216DBC00duciRljtSwMc3nqcq1B8AKIe35Winnwmk9aM6k41BU3Hv4wdb/4et0eq2YCaHRSJ5ijJwkpIcLz31UbmoNhyp/rjcelK70W31bQy/rlURiXTuANnTyARhQXMkCVCGdb5nbNo7KMy87PnlCiNxGqNicsp1u0eS0cnCgj7dom6TY2LEzfzCYxGUUBl8XzvWpgZLQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLNYKVYEQNleS/8siy2t5HrhChl945uTqK+qUohnnjA=;
 b=ZcCT/CWaxRRCxmed1qgY2bjFzw3R6bIh4Jbd58YiMTEMM5o8rO8Fbg6Il0uqeoMNZ6jh1lgc6afZ2NLmlmo284MOo9PnITJyXetiEcqRe4BHM4LAfHEf5m/lTcOqxNqBwvVX9C/2+xJV35WYhg00bX9xuLB2AaTVxAU51Fgbn/WKJI2m2dYG1nF6xZI2ngSiZjEl9qAR3E4nfAuqtJrhEnCOzXLy1MwAsU16rh7kBENvAdibVC7mrD5O1eSdsSfg4fqUi6CrUedE4JRPO7obRVsowDfMYdaet5+EK/4qwDA8RaBZR0V+YtqWZ/rimQ0ubMQ9kp60xiUn4afhrxMawg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLNYKVYEQNleS/8siy2t5HrhChl945uTqK+qUohnnjA=;
 b=yv+LFrVivrMCqUGGOkIcQ6DfJIAAqgfjboP7VkaiZqwlj+wK+Fn2v4BcOB8pZ0A4wbSQiOTuSN5wm9H0RLVclhslNf36HvmsFXx6GJGxeGG/pJlLCb73Et0UAnXUHlsMbh0ZbI2dtcj+KRDAvxdtN5UJg21gTnCq4WH4yx9Dh6Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOYP265MB2208.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:115::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 13:22:13 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 13:22:13 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 May 2026 14:22:12 +0100
Message-Id: <DITHOO6U44DA.3LYRF2NGV1MLQ@garyguo.net>
Subject: Re: [PATCH v5 13/24] rust: platform: make Driver trait
 lifetime-parameterized
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
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260525202921.124698-1-dakr@kernel.org>
 <20260525202921.124698-14-dakr@kernel.org>
In-Reply-To: <20260525202921.124698-14-dakr@kernel.org>
X-ClientProxiedBy: LO4P265CA0124.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::14) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOYP265MB2208:EE_
X-MS-Office365-Filtering-Correlation-Id: e0047f5b-5fdd-46f2-2827-08debbf2f71b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014|921020|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	/A4izN1iLl0AwcUUTpq94gwoJyBCA8/TDMF2BzPQ0cFiVoIcx5eytQVE6ilamlb/VbEu9bJECYwRITg1d85IzPDBa2krKL6j9z0m1GGTTzvhS83s0Hu/vv3dwFjEMAVFfH93LRKzeuFND7ES2qYwGa5NJ3fSpfc96QSTo0+4PMB2ZeJf6bjuHtVa74xKDRX3ZLLJJ5fibW3Qf2vULU2qZQL1lsvaqeYfXtA+03o1087UyePXTkM+eZqmiXVYJmjS/JR0MKosRAOgchbvh/HQ1LpvYUtioabY4tgq49NL6fSLwJV+Gmpag5lN6J5dKQg0CwY7xWSqmS4Fb7W/kKCJVz1vJD/WRkNAsKpFq9maLHxxCqLafES6o1E1H1Sv8VI+VW3BvJvWcj/QpcskOLJUPBo3+Wn02fL9lou8TLEx33LdZaotUShR7VJcmNiQICW3ENVVThmlDA5xY7a+g4Mq80BKHhL84Th7kZIBy4My2Q4QL4Qp0wJvSOry+QEr5O1wsGuU9VWOXLycShXg14d0PwwkolgL71TCaPLPx0yq8BIQWPh0r0RUhrTruoejk7XA+autBQyasVZa7N1UgdZPssF1+Ch8sol3NwKp5izbjcAccQ4L/7YvxgPLOJXhKupdv0H3aeIiF4RwLO2SkmItpLUH/HaMLmE6WnFo+/efvATwRWMj0EJrUDGX6gQd5OgxetPtPluh64KEZjFMnCt7TvS1fwLoVK5HBZFckTwcNak=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(921020)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFRiS0w4b3pLenFtZkJ1ZlEzT255NnZXK1RkdDdZZGJtb28vb2RXY3RDUUxz?=
 =?utf-8?B?OUFNMkJTUVlHNUk1cm55ZE5Jc0YxNlZvVkNNQ2UrRkJ2cWJrcFlxUFZ4b3Aw?=
 =?utf-8?B?MjNDZG4xS3RTVktoK0JhQk5tbXlVTUtLVm1pZnVaRXZLcDNoVWFpRGk3L2t3?=
 =?utf-8?B?ckdKTzRhWW56ekF6Y0xJZmFUUHIxYUFTNXRxSXdsaVdIT1lsUC8zUE1tcUNS?=
 =?utf-8?B?S0ZLRkRYaS9sM3pzU01sMGNGWnBIVEQyNjhRTmMvNHJ1WU9mcUNRYy9xZWcr?=
 =?utf-8?B?WW82SHh1UDA3NW5pTFBxZTFpbDErS3VRRG5vVjZORENKUmJTbEpKbGVJbjU5?=
 =?utf-8?B?K1hqVFF2Mzd5cjU5eFdwdFArV0l4b2I3VG82YUhvTmdpZkZENFZ1ejBKbnVl?=
 =?utf-8?B?R0Y1MlF3WTU3cG52RHl3ZkdlM0FjSW8rbVlmZW05SUVpcjBKbFZpMXJnRmhn?=
 =?utf-8?B?M3J0VVQ0WEtuM2l4NXNkMzlLcWlwZHZrRWhWb1BBUGhqcE44S3lOVW9xUFAv?=
 =?utf-8?B?bHYrMm5uMGRtaUJRWFdUMUtXWWp0OVVHQnNjTm4xcHpHWjlyMlU0d3IrTlFn?=
 =?utf-8?B?TnZsT3M5R1ZpYXpRbFowdzNrQS9xVjAwQ1ZnR3Bsa2MyOXByamFuM29zK3hF?=
 =?utf-8?B?Q1hXNE41NFFjcTBxcUx5Y0EwUUs5d0NYWUxNejVUeFlyN3JIcTExZEtrUE94?=
 =?utf-8?B?aFpYZ09LUGlySTlTR2xiQWRqK2twWXd4T0c2blZOdE5odzJSSkN2dDZ0WGVX?=
 =?utf-8?B?Nm52WUNJN2VTSDhMUEZrY3VCSlhldFE1R2d6Rm9MdXdiMmNranRqUVRZYVlF?=
 =?utf-8?B?b0sxY0Q3YUVnSE9aeUp0aEdHQ1dmYXhYU01qODdjQm1kZStHM3FYN09BZk5I?=
 =?utf-8?B?OGdtZTBZTFRMYkRDTW5PdkVCR00wTlRZanlmZ0IxdXY1VmE0SjZlV3pLNEQw?=
 =?utf-8?B?ZjREM1dSRHUrNkFFWm9oRFAwdk8zZ3NZd1d6TEN3ZnNHUzNpdjl5eVBoYU9v?=
 =?utf-8?B?WWFpRVc5NUhocWJBKzFDZDJiZWkwTlpFem12aG1rUGFuSkxTcFRIWU5IcjY0?=
 =?utf-8?B?cUMvNWlseE1wVTJqOHBMaHl4WUVlZ3VoK3IvbFdPVzF4V2t0ZEk3Y05mQXMy?=
 =?utf-8?B?MEJRNkRIWGl4Nk94czVZMlN2K0JFSHlnOURpU1N4WENyNW9iWU9zdXBzVTF5?=
 =?utf-8?B?RVY3cFNmMzFpSFgyTFVyTHYzNnhSazNlWXBmb1M0S2lwWXJxQW45eVQraERJ?=
 =?utf-8?B?RFo4R3NPTnljMTc4bTliZUt5Rzkxbzl6cXE0YTMvVFdzRFkxYmtnUDdxR09h?=
 =?utf-8?B?djVuTEVEWUh3aHRMQWxhaVR5V0R2RlRYZFlYRHVkaHZhcmgzcmI0OExtaHdE?=
 =?utf-8?B?SE4ySTdmWXM5aWVxMUpJTWNZZitORkFhMGNKVVFJVnpPMXFHZE1DOUJ5UkNk?=
 =?utf-8?B?aElXZjBxT1doSE9wT1htUUNiaHlDVitNZXI2VDNka2dSaWV0eHA0M085Zkcy?=
 =?utf-8?B?bEpCY2tmRFpoY1ZvT0dsQlp0TzFFbGVub2ZWc0FZaXFDTENueWphSjRPakw5?=
 =?utf-8?B?cVhLa1VYd2E5UDJwZUh5Ni96OWNZV0FGVU1YMzhEeGRtWWF4V1luTDBaMVpD?=
 =?utf-8?B?ckRLbkZqZXFRRWFnTVNCT3hhNHE4S3kvaElTNEVmRDZjSWdSR3Z6TGgxTk1X?=
 =?utf-8?B?clBVN1RBQkR2elBVclAxa1pUK3owNEcyb2UxUWlNQ0VzVnUzYlFMUXQzUjhH?=
 =?utf-8?B?eE5MODB1WDRzSjA0QUZNSzZablg2UnYyR2d1VzVMYURIWi92cVB5cmppY3lu?=
 =?utf-8?B?U2dLaG50cGg4WXdSUGFtMncrRlhublEwUVZHNTNtWEMzNWJKN0xUN1BKRkla?=
 =?utf-8?B?eGhHSDVrNmNRaCtBeVlHSkFrUnNOcTV6b0pVQWt4TnFMZ0VFVkkzQldHcXFW?=
 =?utf-8?B?cmZ4TlUyTWdPbTJ6a0Vib1JZdnlhRVQ3N1gxdGkxQXNEQTdkYkRuMSt2cnN5?=
 =?utf-8?B?WEV4K09rNkxVUHgvR3huZEZtdnd3VkJ6ZEloNUhadW4yQjQwS0kzQVg2UHlB?=
 =?utf-8?B?eGFwV3ozZktVSEltdWtMR2NGYy9lU0ZuNUdUSC9NV2NBN05FQkdQWG13ZFRj?=
 =?utf-8?B?ZmhtTS9iNHZvSUNZRUJsYk1mbWNVU3hxNktXTkV5V290VEJhR1JuSjg1aVha?=
 =?utf-8?B?L1BZS2Evc3UvZEVHWU9pdGJFM2ZDRHJLSm9jTHRGT21UKzJNMHN3Y3daM0tv?=
 =?utf-8?B?bVlSZHZCMUpCbVJpejdwVHBUcGZJSHhFNk5iNlFzRUFGaG16bk85WllibXA2?=
 =?utf-8?B?OWhERnhZTFhhQlZZS3dsQlh6bjA4YlU0aEgweTd2TEh4UFRVZEo5dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e0047f5b-5fdd-46f2-2827-08debbf2f71b
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 13:22:13.6187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p3z08Idd7dz82CMlqG/A7pnHA/9w61AUdLu52ClyEuRiKYDRqQhJpoSagF8QS0wusg77xg2MOgiW0x/AsGT9DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB2208
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9169-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 5229D5E4F3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon May 25, 2026 at 9:21 PM BST, Danilo Krummrich wrote:
> Add a 'bound lifetime to the associated Data, changing type Data to type
> Data<'bound>.
>=20
> This allows the driver's bus device private data to capture the device /
> driver bound lifetime; device resources can be stored directly by
> reference rather than requiring Devres.
>=20
> The probe() and unbind() callbacks thus gain a 'bound lifetime parameter
> on the methods themselves; avoiding a global lifetime on the trait impl.
>=20
> Existing drivers set type Data<'bound> =3D Self, preserving the current
> behavior.
>=20
> Acked-by: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  drivers/cpufreq/rcpufreq_dt.rs       | 10 +++++-----
>  drivers/gpu/drm/tyr/driver.rs        | 10 +++++-----
>  drivers/pwm/pwm_th1520.rs            | 10 +++++-----
>  rust/kernel/cpufreq.rs               | 10 +++++-----
>  rust/kernel/io/mem.rs                | 20 ++++++++++----------
>  rust/kernel/platform.rs              | 28 ++++++++++++++--------------
>  samples/rust/rust_debugfs.rs         | 10 +++++-----
>  samples/rust/rust_driver_platform.rs | 10 +++++-----
>  samples/rust/rust_i2c_client.rs      | 15 +++++++++------
>  samples/rust/rust_soc.rs             | 10 +++++-----
>  10 files changed, 68 insertions(+), 65 deletions(-)


