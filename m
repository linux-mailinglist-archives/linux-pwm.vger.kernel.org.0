Return-Path: <linux-pwm+bounces-9177-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPmDAM/0Fmo6ygcAu9opvQ
	(envelope-from <linux-pwm+bounces-9177-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 15:42:39 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 383BE5E538E
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 15:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88B323046360
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 13:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37FB413241;
	Wed, 27 May 2026 13:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="rKbZpPCG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021136.outbound.protection.outlook.com [52.101.100.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EF83FD14F;
	Wed, 27 May 2026 13:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779889149; cv=fail; b=PtA2fLkO7pqdwpDJc7EYfgMJ0FWCug+WCm8oUBtipWoanmsPnBWw3OTDua7XwtyB2aLA30E4mFBQhrDgleEl02TPCVlD/dDMktXoWyvpTUzjlN+5/AWyX8kyEJeyh/vjRuIweoYj7uMima5++ECSVmJ8rRg8lSkV2GALx1WhzDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779889149; c=relaxed/simple;
	bh=CMLcUZl9+rxcgQNzaV+QmTswsGC3+1eyL2MrHlxabt0=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=qRj1IwfypUtWAIb0/03IchB0pNyZ1I7RRzjuOYQAaJrBh7EqhpfyHTjU3fpeYztMIczG0n0a65E5EaOej0XPEdCB+gjoqaAXfzaDGIEX2Y4w8BHzch3tQGoSe+/upyWSMcOFGi/RBEH4OPU+QqaJ/+qbIVhzhzSGgMGzOLWsHgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=rKbZpPCG; arc=fail smtp.client-ip=52.101.100.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mMpdRIiokUjBYQa/EenCyu4CCnwdvG2jgYYAr4mAoo1a7G47QWuRaruFigKyGynTC3lEChU+xX/DG+xwqN9nocdPV/ZNe7thl+S5+hBKo2byXCOG0MXxnT8uvD/0U8nLMdRUzlSzHOqWRMQ1xsSdJC9WDJq4v43Et9cbydECMe1tbc0XG+3ccTN52aIX8AISBmpcLb29RUjLNRiNG94hnZrwE30NveyRAFtBhyCS9V504oifsqInncvCG32fxAyBS0tKZcRC71JHubSn9xxQ/aoBGt6N6JgcvOAkswUMfy2oYvFjaMGaJ9iCvQ8eGvvcCUH7VxIQzOsiTW1nsbP+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVzRcU7cXPH91cGxSGhqGvIVXCZKnfRlRECMSc4TrJ8=;
 b=rdFyXmTmvOYUPpwJzx+xhYVmqZP88wXTSSf09LhrIo2xVDFGoWv1eNeEXSOu1aa6Z1Eo/SOGULwGO76HTjb2wvf0oHGOO4Ntcg7yw2WjoT5eBVDeE3DD8LLmYQG7zk8Mkn3pG6FRrmdNjAGMcMS7QanLSdIXfNcJbHS39/jUWX98SWeT82B/SHfJ7KcvYFUaNtDQd6j/9i9IyElm3/Mg6rnULMFivvqfG9U3ISVfbPC7UnJ5jW1IIV4/POUlsUcLWP1Za/zU4zs2M9rPpAmJ/ii+ehV0d5+RuhC6NALK3EQzTl4yx1XZ0BNKsMFuM1JMVERO13sJ8WvidQM0uCVehg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVzRcU7cXPH91cGxSGhqGvIVXCZKnfRlRECMSc4TrJ8=;
 b=rKbZpPCG/uGdJRhoZkljXTlnWAifAYzlEoGdl4+ZeRKu//zRFExGWIx76lRO+mZvIOgIT1wvWPTydC9yJr5ruMXCUjeaM1ALgR9U10A4Gvvrkag7zteCzSr2ZbBVYZTo8agrm18Vlezyb4ZOMD2PbfrBcfkHUhLHdP3iCaJZ4G4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOAP265MB8486.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:472::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Wed, 27 May
 2026 13:39:01 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 13:39:01 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 May 2026 14:39:00 +0100
Message-Id: <DITI1J1DPO5P.36CKYPRVHLL9M@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Eliot
 Courtney" <ecourtney@nvidia.com>
Subject: Re: [PATCH v5 21/24] gpu: nova-core: separate driver type from
 driver data
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
References: <20260525202921.124698-1-dakr@kernel.org>
 <20260525202921.124698-22-dakr@kernel.org>
In-Reply-To: <20260525202921.124698-22-dakr@kernel.org>
X-ClientProxiedBy: PA7P264CA0105.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:348::19) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOAP265MB8486:EE_
X-MS-Office365-Filtering-Correlation-Id: 40f7f17f-06bb-46c3-1b74-08debbf54ffa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|10070799003|366016|921020|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	9SbGJyx2FqUI6fPvhVQ/PaKn+j5JIdAa/fiEieZmEBAWrlj+oFicxSxoE1SnKdvi4Ii4IbW2/vgvlHB8mUX6JxOeUX+HaXf8XES1r62vNZFkkQhH7Rm7a3hMUX6o2ut28a2UifZCdsTtfss5q8acjnywzmFXmbBhp45ikiheMAvIJrAfPYQ+eyMZAP/f4UYkD6baDL9udCFH8pEMAFHcSYjbD3Xml7FMNSA1xEECLOfPtf6/ar6A/Mm4RucyY2P5HgjUR9mfDS5bCGnu3H2KgpW7Q3EPZxliJtwiYt9OW3IEgzkLmay768fyeZ1axhqJGGf94cZSRC5lRWFX9oTDf1n7mTJieGvAX35p46Yaku/NnNpe09EIibQ6K7OlyMDAbJ4keQ2GU0KH4djEcaUQQsLWB/Se+L5zWNVlZPcck6pEsBk+Fcvc1WMTj7o9XNA9nILu2xDu9TogsxMI2EW+bdJl09jW1BksqqeFFSG6TICbvFPuXILnXHtAPM1ZEbApcrmB7DgaHY/Zzm36wyFkFZH8lN75jg+iiAF6sK+GAQo5QZNJFfJ8UY76wNIe4BnedYEvMP3cJ+zKkPK8qlhV7ufu7EaGg5r1CJ1TleFGpu5HgUzwiXakrey35iCGRPOWOY5+OuzxddjowEV7tfWiqvC8HHOZE1R+nUS3TwbU9JUUxC8GXdwNmQHiVsIhe2H5h8Dby2FH0MFOkbx9BH0/plW9lD6vj8tD4C2lR535NJI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(10070799003)(366016)(921020)(18002099003)(22082099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGk3V3RCLzBpRjFpT0kwMGFxbXQrMEJGQ09malhNVnpUNHZsYkh0MGFId1Rw?=
 =?utf-8?B?Q0JyV040VXJ4SmJ4K1gvYkxxc0VETG94NTh1YXJjZEQybjVFVVlSamNLUS9j?=
 =?utf-8?B?b01hVklna2JqT0lqODlTMk9sMkdZdG5JMWNTRXlFRkJQYnZ5N2NCRFRpbi83?=
 =?utf-8?B?Z1MzNmJhYXhzMFVrVXFFNGtzNFErSEtrVDY3aGxOaHMrOUpDWGt6VnNZUTlt?=
 =?utf-8?B?Njh3azVUSDQ4dldrT3JVakp2OFpJMi90TFpvZFVJc3VEMmZQNjY0bDI0bEk2?=
 =?utf-8?B?cDJqV20xWkhJTEhhNGVSaHBqSnJNa2Q5YXhTYitlUXY3OE9XV1ZlWDU4TEQw?=
 =?utf-8?B?bDJBcjd2bDFWbGdVTk9MVlFQRHIyY0l5eCtoOW1SUVVRK1NBbFRVL1dUTldk?=
 =?utf-8?B?d3ZoSDFlaEJTU3ZEVWpGME05WDNSNVh2ZnNtc2FPZ0F3SjBETzBXdlRRdTlZ?=
 =?utf-8?B?TDZkNVNaWC9Ba1doTVZMYVIvSkJvcFhFRHFDRklPMVBRMnNQcWY0RlRMY2E1?=
 =?utf-8?B?SXRhcGtiOUxTVldpUll0VjI4SFRHWFpJZldsYWJROW9ldHJLMFJvWjFwTzF2?=
 =?utf-8?B?ZHN6K2tUMFY3YUdmTkd0YXRNcVJuTlR0WGRBM2Nsd1dpRThCTkkyeWRsa3Jl?=
 =?utf-8?B?dUI5b1FjRE5WMGRKdDFpL1hTK1pKOTlPWUVweU9EbnBTRS80alp2WDZPSFJF?=
 =?utf-8?B?ZGVPbTJCbUowR0JocFBlQ3hDblk5WkJDbjVXUUU4czhweWNYbFppRXFnVXBJ?=
 =?utf-8?B?WGIxWGtReUg1WlNrQ2U0UXdxT1ZZZFZNaTBERFpFOEFrQmlLZzd3RWZUbkFX?=
 =?utf-8?B?am1EeFpFREFhL2lCR1MzNG9KaUNUakVFN3cvZU56RGtKT21DWThrdllUelVN?=
 =?utf-8?B?Q0R2WlZHV1RzRkFScWlxMGIwdWRaK0FTME1nc2d6VXFjc0FYSWg5RjZ4ck10?=
 =?utf-8?B?ditTZVlTU1J1Nkd2SGtXa05XanhNSUlHV21hMENBcFdoREZzMmN2OTk2MmxC?=
 =?utf-8?B?UzM2ZURBVWI1YmlZUEpTTzVIOVRUeVkzTmVTcUtsYVEvUm9rd1BHL2dLYUdi?=
 =?utf-8?B?eURHSzg2dlJGMy9YOUxPQTZuVG14bDIvL1hkakVUaDd4QU1zRFhQWGxaOXBh?=
 =?utf-8?B?UnFWYnJJMHdPS2J4bFcvcGlKd01zcjJ2NW54cW1jYlNlcU1Wc1N4NDAzZklq?=
 =?utf-8?B?MUJCZE5CengrUktpeEEwUjdkYTViZ2RiSWNTSGZTejNtT25OM29TVUpxT3h4?=
 =?utf-8?B?VUY5dUZGRmRXelFSK3UwVnZOQXpzMjBrZHVHSTg4TVdPYk51a3EwQmZIdXJG?=
 =?utf-8?B?RC9WWEI0UklkSmNmSDBGQ2N6QVZDeDdBT3VlNVRKU3BmRHJsdTA2VEYrZHpG?=
 =?utf-8?B?dHVKOTlscDVkT3ZIUHJFRWRJN2Z6aFFvcmJvZmlGYzU0bzk3T0VDWDAyQjZT?=
 =?utf-8?B?cFdFclk3bWZnSUoyQ3l3Y00xcGxkeURCMWkvNXliOG1pUGNnMHdWYVhBaHRx?=
 =?utf-8?B?blBZMitKTUE2Y0Y3bXZYM1RXa0xpcDVYVWRCNlJaalhWOGQ4SEZLb2VscXE3?=
 =?utf-8?B?VEpKZ0lkZUMwcVdzOGkxZlBqbGxTSXhMQ3dGYjZGZFNKRG9wSUVHN3VUNStF?=
 =?utf-8?B?VW9GSlZTQlUyelRkNHAzTmMvNk9PZldlcVFFYjdnWjcwcDhMM1VDKzVaTWo5?=
 =?utf-8?B?N24rbVZMTGtnL1c4dWV1QklZandMcG1ld3VISElzSXZkWXBwcGczakE4R0VG?=
 =?utf-8?B?ZnQ1eEVYS3V6bnZJRWg4ODBjSDVJcTh0eDFidTNsOWd3NTg2Wkl4K21xdXcz?=
 =?utf-8?B?WEdpbC9WSytaWEZpU1FYaEx2dVpremZTZncwS2libE4zWmxBVEs4aDhiczdp?=
 =?utf-8?B?K0R6VGxtZTBDSEhzRnpRejNLcS8rL0xZbEtpK2JKL1VBbU0vdElOZ2NFaHcy?=
 =?utf-8?B?amxGbDRLK0h6c04rRis4N0ZyTFZ2eEFPaExrYVhFK2pwYTJnVWF6R0MxSzRN?=
 =?utf-8?B?SEJWM3FIVDRINDdqTEhDdHpoQ0NVbmorV1UyRjdOVmZwc1V4OTJnNVg4NEFM?=
 =?utf-8?B?YkwrVE9CcGZDU0ZmSVppMjN1NDFEa0s1cXlsNUFRdEkyNk4rdGVXV2ZHdHdI?=
 =?utf-8?B?ZVNrVmp0eXdvdWhFMWErVStPWlNueVpDS1JyZHVrdCtPTnZ6Z29MUVhxZjFy?=
 =?utf-8?B?WkdFdkNBb1A3SVJHNC9aODFnNDFwanAyMjhpQTFheTFjNzlpU1RudGt1azVY?=
 =?utf-8?B?bU1XM3c5eFc2MTBvWGpsQkVsbmpaNmdGbHdXb1dNMWZRcWVadzFmNXlOTjBk?=
 =?utf-8?B?MWdQWjJwS3FiTTh2T0ZWYnJ0Qy83VkNvYmlKMzZtUUUxMDllbWlLdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f7f17f-06bb-46c3-1b74-08debbf54ffa
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 13:39:01.7432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A3QBIfVc/Lo//8yK1GAP84HkdJ9kpXgGgYxdBPXaPNH6ztghcLErUpRwPXnm4T76vEAFXla5yT/E/Er0JwhXyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP265MB8486
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9177-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,nvidia.com:email,garyguo.net:email,garyguo.net:mid,garyguo.net:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 383BE5E538E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon May 25, 2026 at 9:21 PM BST, Danilo Krummrich wrote:
> Introduce NovaCoreDriver as the driver type implementing pci::Driver,
> keeping NovaCore as the per-device data type. This prepares for making
> NovaCore lifetime-parameterized once auxiliary::Registration requires a
> lifetime for the binding scope.
>=20
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  drivers/gpu/nova-core/driver.rs    | 14 ++++++++------
>  drivers/gpu/nova-core/nova_core.rs |  2 +-
>  2 files changed, 9 insertions(+), 7 deletions(-)


