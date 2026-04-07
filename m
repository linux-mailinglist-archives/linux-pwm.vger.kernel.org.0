Return-Path: <linux-pwm+bounces-8506-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOPxKPWc1Gl1vwcAu9opvQ
	(envelope-from <linux-pwm+bounces-8506-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 07 Apr 2026 07:58:13 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAC43AA1E5
	for <lists+linux-pwm@lfdr.de>; Tue, 07 Apr 2026 07:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0507B3019143
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Apr 2026 05:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40022379987;
	Tue,  7 Apr 2026 05:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="RCTAzifE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazolkn19011062.outbound.protection.outlook.com [52.103.14.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC13F372B5A;
	Tue,  7 Apr 2026 05:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775541490; cv=fail; b=WzrT/YBLIQgFSHpA4P+M93l6ahPPiO3CGLTe+KDpbWd9jDpCTOyY24gEToP1E4nFcW6T37n1gur2oBTMZwda15hTWGIbX0k7I4BteqJb/Hx/2LUJSVXNWo6Uotu+sIqYkMPctwsl/hJ5wjGkJZ9wJE8HMGidrijG8qVUU9+cwsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775541490; c=relaxed/simple;
	bh=MTXAWLFoJH9xw1A3im91T7feiFBQ8CxZqxltQ3pDuoI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IPZfpttuljNg4sBSN83BQpr+/bYuZ0DdnsLg85yCVS6+26eyK9rb+QuSszfirR+6/KbhMvcZm/M5vXsIJUwbG1+9cn2ranDQVgiMLhPMe/gUTfdRvUk/QJwbe+e9TsMWJQp7nb+E/KzqHRfolKv5ZEaqy7zXYVs1bc2V4vr9x34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=RCTAzifE; arc=fail smtp.client-ip=52.103.14.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJhE37njJ40V2BvXv6KQVxi6rsCJd6zJuQql7iRrIG6zI0l4EpItfXhqfjymJBE9ZdHOy64MdWSWF1fv04nTDHElBu4P41TdfWUAcsPt7S3pTRfj3qTOfmUdTa37Ub8mZPjNBXF5qQwNAG0lE9I0BiK0fDouo2N+yxy5tux8r3nFxg5CvVt+aHuA8I0SfSyCsIm1DYgBYuMe4bu40JYvhPW+adV5/8Dr22Q+nvEEs0OuH+J5FO1xC1d5apQeS9OnHwUuMaa+0ZUxZtI5oULMGP97ttVkQO3/LZNoENeUbrDu9296gWyvgrPannb24jZyGxVJPVeujtlOImvkG0EAfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b5U1WVJx206ipwKIijXSW7TeTyYY48oqrUGH8np580c=;
 b=Q52zwBb9r8TLpknQPcnXqBEgkoKggqwXu4sjc0CWEov8Iez6VvYbcA3JG0bW7Ni0qTOFu7gh5nAMVwi27fFP0TLkwxPncGKz5vth73YJ9ZikT1nf62Zgq3wfwSbjTRhQzMehLvD8wAQorvfhCdewpZZMTv0J5uDSxWVOA9QSodYwJ5kfg1DnR1slBL9J1DfpVi/JnYM5F22HloqV5FBlK6gz0Pa8UyzVXa14NKol8kBKzIDRPRx+KcHysUjuuy3mt7SZ/lznY/T413rkdAPiwRVL6CO9A9H+j24jxcC28kAjO3ewjsXrtFEOd+m+UgUjlBzp8cHEwhpejnXN9PuOuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5U1WVJx206ipwKIijXSW7TeTyYY48oqrUGH8np580c=;
 b=RCTAzifEwj/wQvpaPFPgcWb0ogbfAZs8PWq9fPGrNbQX5XRUtFJHUYRiw7XPPZWCRdVBAJ8+ZK5146DRLYN22Z75PdcUqdFM0tiE76K2Jmj09dlK6c4QBTY0bdsXVtzWdXF5g/L854mZK2oANMdsP+6yMDuf8g7bZdJDG1+5UKCxfwyqNvsqH1wpMovISqDFFXCfX/hKIsKGe7W6DYht9DELEHbYZ0+tE5hMy6xz5zcQ1YigIBH1pN51huvEmEpkPHR4Zb66uYDgGWLrQ45/rMYQ2/QHScRarBB2y7hTuCJ5HhFWLGyKNJ5JldTzaxVILJCuUnARhmPKyJSFIPGXig==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by CH9PR19MB9612.namprd19.prod.outlook.com (2603:10b6:610:2e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 7 Apr
 2026 05:58:07 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::5880:19f:c819:c921]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::5880:19f:c819:c921%4]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 05:58:06 +0000
Message-ID:
 <DS7PR19MB8883B8AF9C85ABF5B485624E9D5AA@DS7PR19MB8883.namprd19.prod.outlook.com>
Date: Tue, 7 Apr 2026 07:58:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 2/6] pwm: driver for qualcomm ipq6018 pwm block
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Devi Priya <quic_devipriy@quicinc.com>,
 Baruch Siach <baruch.siach@siklu.com>
References: <20260204-ipq-pwm-v20-0-91733011a3d1@outlook.com>
 <20260204-ipq-pwm-v20-2-91733011a3d1@outlook.com>
 <ac6MP-O2MNDkleZB@monoceros>
 <DS7PR19MB8883555F6B620250D1CB55689D5EA@DS7PR19MB8883.namprd19.prod.outlook.com>
 <adF9VdZYEGQfRqyl@monoceros>
Content-Language: en-US
From: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <adF9VdZYEGQfRqyl@monoceros>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0026.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::13) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <57a3c571-54a9-4088-8c7c-4b20b5b2e63d@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|CH9PR19MB9612:EE_
X-MS-Office365-Filtering-Correlation-Id: 9921147a-905f-47d7-0b37-08de946aa31f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|8060799015|12121999013|6090799003|5072599009|19110799012|461199028|37011999003|23021999003|15080799012|41001999006|40105399003|3412199025|440099028|26121999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDlsNldkZ25sdVJzYVl5elBaaTNlaVhiZUw0Mk41dCtudjhWcHh3R1o2SEtG?=
 =?utf-8?B?QU5FeTJ5ZGxrdHBuYmttcFAzQVFVamp3V3ZrMVZaR1QrYkQxdk92UkhmY2pC?=
 =?utf-8?B?T0xKdk9pZTRDbU1qQTV0S2Iwdml4RVBiaWIyN2o3MUx6Nzh6RE9aRlNDc2o5?=
 =?utf-8?B?ODk2MHQwMTk2TXNjeklKV09kd0tsSVpaVzFXb243NkNWTWVITTgzZE95ZUVV?=
 =?utf-8?B?anFZZGxudnAzODNUWGJ3VHNJeE5SVVhPQkFZMWtjeG1LVmxJQ3ZreGpyRnp1?=
 =?utf-8?B?d0lscTZJakY2ZHZ1SjlkOTJZd1VPTUtIeHNIcUFTM2RkcDJwSXh4STR1R3p4?=
 =?utf-8?B?d0VDZWowSTdySW9VSllQbzRWSzVhSmUxaDM3Y0FoQ3NmV0lVUzZ0MFRrWDgx?=
 =?utf-8?B?NC9KajZMd0R5czNwY1RraHpOTGtmTDIzQVltUHlIT0NqY3hpZHd1ZldJM2xl?=
 =?utf-8?B?WUp3UFlkbVFJcExhMHN1V2tTQkJOSWdETVdwUXBaYSthbWY3Q0UrMGUxOXR0?=
 =?utf-8?B?THR0VlpkbzJXektpbjEvajk1aUI5VFdyUDk3SjVUWHZpTHJYWTR6azNXNjNx?=
 =?utf-8?B?eThSOVJpZlpYeVBGZ2tFdEJVZWFKY0I2NC9Qek1hM1QxSUdwRUJ1K1RHQmNE?=
 =?utf-8?B?cklRRGtjUDlNbVFVdVVvMWFoVjNGNFE4aFF6V29NeTNuTHZZZXlhT1lpUWR5?=
 =?utf-8?B?U1lUVEZrS1ArTndXWEVScUxpRXdpSlRMb0lUZUMxYVZOQUNtR3JQTlNQTVpJ?=
 =?utf-8?B?alhjd2RaQTBMaFhuWHF6bjNxNVlDakxEUllKTHBZbzVEUHMvVWhaUWs3SDVY?=
 =?utf-8?B?WEtPZ0c1QkcvRHZRbDdFV05GRlRjVjdtVW11SzlaYnViZGc5eXEyaTd3U3Nl?=
 =?utf-8?B?L2pWWWx0Z09DTTYyWmdLYlc3Yld1MzJYbi9zVHNYK0Y0YVFPQXFxNXV4cFNR?=
 =?utf-8?B?b1NMb0pzZ2FzTTYvQktvQlp6Y0ZNcTRQNXZ3Z01kVndvVGt1ZFFYZ3BxN1RS?=
 =?utf-8?B?eHlvVTVFbEIxZ0N0S2c2ZXZuT1o3ZVlreFZWYU1NZTY3SldwUzJ4RGFiYmtr?=
 =?utf-8?B?aENyMk1LSHJiSUFBVW9nWThRdTlXeWxaaStaclQzQ0VVd01RMXZRZ3lTMDZY?=
 =?utf-8?B?ZW5ZamNCdFA1MDhUWnJUbnJhZkRNclBsZFJ2akJsM1M5dTRNREMwV3Arb3Zh?=
 =?utf-8?B?U21qZkJnVjdaNXZnaUxSa1RRaTRGZzZPaXZVZFZ5S2dPd1o5Vko2T0M3ZTBU?=
 =?utf-8?B?Um93TFVSMHVadm9xQ3JoT0x6SUt5R1NMUXVnUDROa21nMm5xK2JTSW9uSnZP?=
 =?utf-8?B?bHFsaENHbExTUGxpdzdNZmJRRUhic0M2cXRSemxicTRDdmdIRTltRlpSNkFF?=
 =?utf-8?B?Q0ZTVXE0ZkVqa0RlTE9GTG1XRVdtSm5SRWJCK2NWVkxDMDgxRVdyNHNPRTA2?=
 =?utf-8?Q?o1yMb3ri?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjcrTzhHdFZndUJVWFo2ZWFjTVlzMXhxTVJSTE1YczROT3JZaUQwVndDTkV1?=
 =?utf-8?B?MUZzVGlWcmFoQ0ZBRjZNOVMyTGV4M2VkT1ZmaUpoTUZDbDgrVkt0UmNWWHA4?=
 =?utf-8?B?bksxUzIzMDV3MlNXbGFIYUk0dE5RbWdwODZJMmxoWFNBNERGOUJ0eTRQbndN?=
 =?utf-8?B?L2FPODc3WGFuWjM4M3RNbFI0RDBQZHlzQm11SVNXRmIxdWZaczdMWUdMUERm?=
 =?utf-8?B?SllBVVhsUGNNVllCY3E5Q0NvUWEyRE0wYmRFU1g5R2phOFQyL0xOWlY3Rm9T?=
 =?utf-8?B?MUJGZkxBWlhqYklxcGtGRlY0Y2JRRVo3OHhLOEswZkMxbHYzemRwTlM5NFFY?=
 =?utf-8?B?WnlLR05Md21qbkpidkNtNS9pb0dNUnhWZFl6Rk9wLzg3YXI1bStHdVUyZEtt?=
 =?utf-8?B?TW1JTlJZbkl2SFd1TmEwRytEWW04WUxpYUlvV1FzRzJGZ2dvbzJyT2lhaGtt?=
 =?utf-8?B?UXlQRzFPOU9QaWxnRllxVzVYUWZsU1h5NkVRTFN6ZXBpTmZrOTZtaW5TRkNu?=
 =?utf-8?B?ZUhwa2FTTy8rSlFYN2FoRWFoRFhzRzJIOGJzYVJ3SGZpUEpIWUlMcXlFSTNS?=
 =?utf-8?B?ellCT0hJeXcxSnllU01Nemxva1ZEVVg5bXR2aHdFYVVUS1N6dFdzNnRMUGNj?=
 =?utf-8?B?VE93QnV2NnlDVjJUemx1eUxQZ2NZdDdqdHl4RTVWZVZOWCt0eXZkdlpUQk5G?=
 =?utf-8?B?TFBYaVdGd0JHRzBrR1ZVdGdENEg2UmtuUWxiWmRHR1VOUEFkczI4Q2k0bzJV?=
 =?utf-8?B?YjdEdFBTRDlyckFKNnpZeTJqSzlZUmtTUjdWVGxBWHFyQnhseXZFNjJyL093?=
 =?utf-8?B?d21ZUDFjZ2REZ0xMNkY4eEZmMXhXNWlmN3llQk9lT0VPL290NjdFNEVtTTRN?=
 =?utf-8?B?ditydndyejd4RERUTEdVUUpTY0lMRDhYOFhFNVlGS1RoZnpYaXk4KzZHMjJF?=
 =?utf-8?B?elYvN0pZelNOalcxdG9QRDVjMWwvekdwK2YrTGc2enNNTER2cHoyOHZQdC9v?=
 =?utf-8?B?NDNpUzVRaWRZbXZsdFNXMk9VR2ZrUHBHY3ZqT28yTW1NbnpveTZBTVp3OVhT?=
 =?utf-8?B?eGlmMUZnaGdDNDVGTUh5VEVvZ1VEQzBmT1owazVLKzY3WjFsakNMZE9SWjhT?=
 =?utf-8?B?RmQxVTBrN2Q2MnZvMjFMZGFqSW82c0FKM016K3Q4ZHRub2lkYyt5UU5YcTg0?=
 =?utf-8?B?bVNLRmZIdkNyY2FlaHZHeU5hb0JNcWFtTjNsSEg4eUJNb1NvT3N5RjFUNFBG?=
 =?utf-8?B?dEljWHNDdVI2QW1SZWtzUUx0bDJPYWtvbUJSOXRjWisyVWhkZ1BzaW1rN0JC?=
 =?utf-8?B?VTQyZEhMcFJxMDNXVHNGQXV4QlNWMUw0ZmpRbE1MWE1wOWo3QTRSZDVNRGVF?=
 =?utf-8?B?MkpyM2xvMXBiMjJzaSs0OTVUNWo4N1h6VUpvM1hXOXI3RW1ZRVQ0d2ExZ1Mx?=
 =?utf-8?B?cDhtb2JOaDZuaTV2UzZGdnhBUHRlV0FkR1hvcitZU2hMY0VhckNFOEpOUzd4?=
 =?utf-8?B?NDZkMTJIb0tJTEprU29MdWpxb0xIK0x4NDNtbFBCTEwrSkUyT2dvVDc0M09S?=
 =?utf-8?B?dzNLV0M2SEU1YlFuUE52bUpicUNaeG10cFpCMS9vVHR5R2syNElnWXBndTVZ?=
 =?utf-8?B?MmprdFpTVmVIYVBJbzNWQkdCakFlcW5Za25ONjZISWIzRWpFOXRBVEswTzVu?=
 =?utf-8?B?L1ArT3pVOERramMrc0d1aEhjMkNxemU0MlhCK0ljd2NWaWIwMU9LZjZxQkRm?=
 =?utf-8?B?b09MdWJqVVdLeXl0WnBXUVR1NE9lVzVRNTdOT3FPbDIwRUp4MVBKZVkvdm1H?=
 =?utf-8?B?eFFQdzdSOVBiUjQrTDNJNXFINDU0RmhNVEdWSjJXZ2VyUk5sZVpzc2FxblJP?=
 =?utf-8?B?c1djYnM2VldsdzVXcG1KaURzR1ZmRDZiUUJQZUY3MElWL0E9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9921147a-905f-47d7-0b37-08de946aa31f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 05:58:06.6902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR19MB9612
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8506-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_MUA_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[george.moussalem@outlook.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:dkim]
X-Rspamd-Queue-Id: 1BAC43AA1E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/4/2026 11:09 PM, Uwe Kleine-König wrote:
> Hello George,
> 
> On Fri, Apr 03, 2026 at 12:40:32PM +0200, George Moussalem wrote:
>> On 4/2/2026 5:35 PM, Uwe Kleine-König wrote:
>>> diff --git a/drivers/pwm/pwm-ipq.c b/drivers/pwm/pwm-ipq.c
>>> index b944ecb456d5..4818d0170d53 100644
>>> --- a/drivers/pwm/pwm-ipq.c
>>> +++ b/drivers/pwm/pwm-ipq.c
>>> @@ -97,9 +97,10 @@ static int ipq_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>>>  	if (state->polarity != PWM_POLARITY_NORMAL)
>>>  		return -EINVAL;
>>>  
>>> -	if (!ipq_chip->clk_rate)
>>> -		return -EINVAL;
>>> -
>>> +	/*
>>> +	 * XXX Why? A comment please. (Is this already covered by the checks
>>> +	 * below?)
>>> +	 */
>>
>> This check can be safely removed as it is indeed covered by the check
>> where the period_ns is limited to IPQ_PWM_MAX_PERIOD_NS which equals to
>> NSEC_PER_SEC as per macro definition above.
>>
>>>  	if (state->period < DIV64_U64_ROUND_UP(NSEC_PER_SEC,
>>>  					       ipq_chip->clk_rate))
>>>  		return -ERANGE;
>>> @@ -107,18 +108,29 @@ static int ipq_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>>>  	period_ns = min(state->period, IPQ_PWM_MAX_PERIOD_NS);
>>>  	duty_ns = min(state->duty_cycle, period_ns);
>>>  
>>> +	/*
>>> +	 * Pick the maximal value for PWM_DIV that still allows a
>>> +	 * 100% relative duty cycle. This allows a fine grained
>>> +	 * selection of duty cycles.
>>> +	 */
>>>  	pwm_div = IPQ_PWM_MAX_DIV - 1;
>>> +
>>> +	/*
>>> +	 * XXX mul_u64_u64_div_u64 returns an u64, this might overflow the
>>> +	 * unsigned int pre_div.
>>> +	 */
>>
>> Theoretically, yes, but in practice it won't due to above constraints.
>> Take the max period of 10^9 (NSEC_PER_SEC) * max clock rate of 10^9 (1
>> GHz), then the numerator becomes 10^18. Divide that by 10^9
>> (NSEC_PER_SEC) * 65,535 (IPQ_PWM_MAX_DIV) and that fits well into a
>> 32-bit integer.
> 
> OK, please put that in a comment.
> 
>> Do you want me to send a v21 or can you apply the diff in your tree with
>> above deletion and comment?
> 
> Yes, please send a v21.

Just to circle back, I've sent v21. Can you please review and get it
merged if there are no further comments?

> 
> Best regards
> Uwe

Thanks,
George

