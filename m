Return-Path: <linux-pwm+bounces-9025-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HGlGYWWDGp1jAUAu9opvQ
	(envelope-from <linux-pwm+bounces-9025-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 18:57:41 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C479E582B9D
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 18:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D9F0301325F
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 16:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19242403EB9;
	Tue, 19 May 2026 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="JjCjye7N"
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020119.outbound.protection.outlook.com [52.101.196.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6354047886E;
	Tue, 19 May 2026 16:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779209111; cv=fail; b=C3AmkA8Yzd/ZIT4HBQi4uB2toMGjA2saqgEBb29qmr2MZTBICZ89vwHHImJUD3iXEo2J1k5XgH5sjIOn/mZ1a+BfCb/dG0I6RqewUj12QO4KKZQG0rri0ahcfqx03/T1DbLwuEQbztFSGxrwA4J2Z0IzzmgeqMRoy+2dbiGL7LY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779209111; c=relaxed/simple;
	bh=NXbgdZfM36UF3QRos8s02O30+g+MQ0ONyHQ3oLjiSBY=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=ZbFkN6mAhOFN0pK/WaXL5wjDuU461A/1+ccOcneP5+PmhsSwQXpPyhwA7nIFjM9OqW58HdAWJXr1yAW52oO17iJ5ROAz9+WzDl03iu4kSqCPKLRFs3wCaYtBxs1IKlupt3uBMF0mc/TD+TBeUZvCUclu5aYOCoVbWVUEW2GXRSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=JjCjye7N; arc=fail smtp.client-ip=52.101.196.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bgzdPssUKb32pAEF2kumPc+WfEWUJ7bACp/6bAwwtcxz/hCLRHMehIgS41P143QHmkebuuKm2UZxoorGblU229ue7FOEFrm+EonCxaPy1zgnnHiRxfx+VTCvFjoyxz2mCSoSlZbBNno1tOn5tafSFIbIw+fMqSjHSUHuXgL7uLi6SPmmJIL50G7DH8REae76adTA2s/bQtDoP5W1V7HFEQyXc0vtVlBs1Vo5L2ZNdsXijB5Pb/r35+4zTZx+UFkSWu1JnAlnrfQAYctWei+yjF9wRxH/9pfqTlLumIk2CKIbVt0wj+iHMD3usxJl2OM4D2vuf6iSMv3OOBWGHfoBGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRWpgY4gV8Z8iG0eG+sEUmLFzWOT4hZs6o2O31bFlS0=;
 b=V2r97yT1ycGza6vtBiLRg+xQr77DoC0tzzWeoQw+U06JycUcT/o3HWFG77e75f+qAPDqPsnF+xO62f2K5D5HJnrk4ZBGbGqNSMW0HedMZhlunGf+OeVM1NZkUKoC5k7CHM16lzCa1mcJC3tHjs4oPXJPOmXETysYRVS5aKfyaMlt8yy8Z+8hKMKv81SxqF3D4eXQZ2qz2Etg6PvgUsA1Wf98Rv1b9rFpa2I7jd00LAzXY6BzueTt5+KLcaVxagavvDVCuf5CJv5bzjcwV9HJlfnmNtI+vZJI5JTQLe0a99G3vZQy+eIZPfU92hL7ZwO4QjPQggu9M8vGZNQtKJWqPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRWpgY4gV8Z8iG0eG+sEUmLFzWOT4hZs6o2O31bFlS0=;
 b=JjCjye7NOBMHME4w7OGhAIvCUQtkDZnFK3Z8AlhGKqOdHvULnNDCpFYKlTOC8FcUckuF4YHZx3xMbd2e60Zpfehgyly45DRKDjk72BwIpGuI24DeLQHCjirO6Ry4Nkyxa2g5D8gG2/Bkr94/Zz1wpathXgvlBpSkN4/2pPBO1h8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CW1P265MB9261.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:271::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 16:45:04 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 16:45:04 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 17:45:03 +0100
Message-Id: <DIMSZMCNTRA0.29WGE6IL25A6Q@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 17/27] rust: auxiliary: generalize Registration over
 ForLt
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
 <20260517000149.3226762-18-dakr@kernel.org>
In-Reply-To: <20260517000149.3226762-18-dakr@kernel.org>
X-ClientProxiedBy: LO4P265CA0269.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::9) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CW1P265MB9261:EE_
X-MS-Office365-Filtering-Correlation-Id: 07c454a3-7630-460b-8599-08deb5c5f9fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003|921020|18002099003|56012099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	0kRtVNrgVZWzOCp6ef8C0fffSE82V5+dpYYHxMFY9ottTdLD/Mg5JeS6KGLqZ5p31IlYiOCtxrDiHN3wIpmcVhYo3nL2oQzBQTmj4KXvV3Z5Dp/eeLRh/jgVkkVR7IQSHN1X5JemVBdNAX3Qy0QunhUY6Exj3DrnyfLVo7M76lHx/6LcOUtuhiojYKwE9177vqcwoqwwj/VSVcZyQgTfhMD/2nJEs58eBZOTW8NQQO1WTnrclF+aOrf4VAQVnH9RU+ydOn50V8Tq6SGRzeuR4TW6qOHDRowvi1ezgyC+YYb378XX305go535H1Ovd/QoMp9lPylZfRW8SxnZY6kRrJ4e9UuYMHucJfVFDn6x0LqJlY71gmeY9fczM85cyvI71mYqaSIShSj+TqsGOORfF/QLXjbH01VkCOfUZMqaEhwAvYZvlk7mTtqlTa8NnsMTUbkMFxa0sjQJqR4mQTzveSgZ3RU01wS99OQvjtAb7x+PpFi9WzXqmSmOsK5rqD9lwTWSK5XqtU/B8SA6NrsjdAIawswlXVUIvNa5DGAQvkFtnMqx5qcvO7+D0SDf+XxEXeXGr5N8GvACY6PnRzzoDz8bVASkP3lrQuv0MV579JD0CQ9yvnimLkv8mdJbymIJO88FYchd6sEZhVvpu14yEv5xQ+bEWXQb7uP6hVXYu+nnELLv6H8B63ia3RflNMkEEfaabp0xHNJjyQBhnxUcBgFfV+rzkDH/+k2ofZN9LVPboE+kxNOte3jck9yCAaqb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(921020)(18002099003)(56012099003)(22082099003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVh3YXdpeWpsd1Q1R1pBcVVmM0dKSmNQNEQ4bndHdWtJSGladEQyOTRBcy9F?=
 =?utf-8?B?Y2VpcWtKanpSVFlBTE5ERHBuMEE0YjExbVpuMnNvYWpRY2lKKzdsVW8vZDhF?=
 =?utf-8?B?amJuWWZPZjVFZkFodVlTN2NxbUJpOWM1cVE3UTFIK3VERlFHRVp5c3VIbytO?=
 =?utf-8?B?QXhLdlc0Y2Q4a1phb0hMTG5Kb0p6RzJhYTZKWXFlK1F0ZEd0NHhjUjB0d2xn?=
 =?utf-8?B?SnpMYThaQ3RSYlBjSFpLUGg5MXk4dFVHa0sxd29LbXBIajFQOW9xVHB2ZFBl?=
 =?utf-8?B?dkxHeFhnNnNFeVk4ejdWeWVHSHhLNmI1V1FIVXhmS0xkMFA3QkJMMjBHeWJt?=
 =?utf-8?B?ajRGaDBQd2FrY2E1bnNrVytFZDEzUUdIQmZpRzA5WUJ3S2pveWg4SWxQbG1G?=
 =?utf-8?B?aWhiQnV1M1g3SnRVN1dlWHdpenJYcUkyaElLSzROT0NFaUhzbUQzV0lXb0ZL?=
 =?utf-8?B?a3QwNVJQam0wNHZQMWs0QmdaWGxIenVnYUl6ZDc2a1lzUkNJYm40cTN0b0R5?=
 =?utf-8?B?ek1NNkJNSVAwWGN4a3l0OGp2bThxNmdNcndITzQ4VTJ2c2R0NXBqU292ekE0?=
 =?utf-8?B?Um1qYVpCQUEvTHhWSitQb2ZUdlRkTURTN0ZuSE10dWE0V0pLcG0zNW9ZM0Jp?=
 =?utf-8?B?MVRzR1ZJNXArNVk4YlVBYVFHaXEzWTNaelUrb3Q1MXphZXd4dXM2enVLQlFI?=
 =?utf-8?B?aWw5TmJtYkkrQm5Mak0yOXZuVmxnbjJhYVhJOEt0T3J2aHNZdHhqUjFsb1k2?=
 =?utf-8?B?aWZXM1lsQ3B2SFhDTU1sR3dWbVFaYmpZSHhWMkdjdDB3L1Jrd3JERWRjOVJG?=
 =?utf-8?B?dlpkRjNpRVFaOCtvTjNHbm01elpMSGo5SjJCaFllN3ZQaTZXbHpzMEhpUFVD?=
 =?utf-8?B?aWVLWmQzR3RrQ3pOa1M2N09lcFdhdi9ZbmlIVUVwVzlmdzVZcjN3ODh3d2E5?=
 =?utf-8?B?NEI4L1VJcTJHQmlRbHV5SjJrYi9XL0dkVmJvQUZ0dWc5eU1YOHhqRmVTQzlE?=
 =?utf-8?B?N21PTlp4Q0UzU1FLQm45ZnFTQU05MlBSbkhOLzg2MjMzbWw3VlVOMHVrZTRK?=
 =?utf-8?B?NG9QOUcvQWQrYnZwb2lKQmRwakdkcFAzeHRQWVl5VDdzYnN2QmFhTDE0cTA1?=
 =?utf-8?B?cCt4YlJna216MktyY0xyTWs2TVpaeFg2bWlzU0dnSlJ2Szc1Zm4xSXh1NFcx?=
 =?utf-8?B?Z290V2xNZm11WGdLY2hlcWVPTHIzZnlDeFZjSnNWR2Nyd0xaZUlaamdVS3Fj?=
 =?utf-8?B?UlRrdUZEQ3hnay9ROU5lSGx1SjFXK3I0Z2F1bVJqRDR0bkZlSU5xNWFhZFhn?=
 =?utf-8?B?TTVxaWtnbERBUFd5VkNjdFNtZDBxTE44Y1VHWUxxUzhPTTBGbGJONlBOYkZM?=
 =?utf-8?B?MGU4MTlINm9SUnZqL0ZSMzdKQlRLc2d5bVZHbm8ydTl2VytTYTMxTjRWcjBO?=
 =?utf-8?B?aUp5NC9hMktJTzNLbGZkRTlUS0k0ckNSQm05dE1hUlF2L1BnMjFpN0xkS0pq?=
 =?utf-8?B?VXExMitqR2dXSE5zNTg5T3hhTFd6dEl6d3ZiNTVDb0pZeFhEN01YYmhHOW5J?=
 =?utf-8?B?cERSanpnTUZlOW9KZjBRNENRV252MkdEaStHSkJFajNBZzJTQWVBOFBYQmtv?=
 =?utf-8?B?Z1l5WDAzOCs2NitjNzgwQ2c2ZFlHKzI1c2ZFVEdjeEFqR3pTVWNQY3JpR1h4?=
 =?utf-8?B?TTJDNWFRTENuNWxORlIvNmgrRW9MRUR0a2gvUU5XWFIrK0k2ck53OVMrMnNz?=
 =?utf-8?B?azFZQWFPdHZqb3VjSFF4WnNYU2tJdkJSSnc1ZzQ0L0xOTkp1cTV1YjdyUktJ?=
 =?utf-8?B?Qy8yZXlzOUNsUG9XdHhTOWh0VG5CVXNSYjRKSEtMU051VFBEMVNLZmcrNEhu?=
 =?utf-8?B?N0tQVEhkdjN4T1RNazJ5NURRb1kyMFpUcVVHaDEwK1dNUkdTMU9mYUUyRXMv?=
 =?utf-8?B?MmtEQ25QTGJtbHA5NmJOUWlYdjZtaThqSU1ueHRIc09lcklhc3A1MldPMjh0?=
 =?utf-8?B?YzdRMjFpZmNSSHBucmhiZzNha0FTVVFwTnJUdG1KQVRLcWc4YXJVbnI0Yjc1?=
 =?utf-8?B?VzlkOFpxYWtNZGVuYVdkUWFVdWtLNFlQYnBweTJsbFVJU1JnRTM4V3dza1Jw?=
 =?utf-8?B?WTJrR3pudk92OXFPVFhHaHpqWS9BUzJOQ3JwaDh0alIweFhBUGlZYmxJQk1T?=
 =?utf-8?B?aHFkYldKVDFmdWlSbjByRUpiRlh6QXBvUWhLNFNFNWFVVktyczd6cm9JRDRl?=
 =?utf-8?B?eXh5QWc3VDRpb1J4SGVzOXV1SUZEa3UzYkhqVnpmK0F6RmxsUURlVUg3SzNT?=
 =?utf-8?B?bU9WLzRkVVBjZFRrczFFUTNzZHJ2VnpVeEhNSzJDL2RVbUNpWTV3dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c454a3-7630-460b-8599-08deb5c5f9fb
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 16:45:04.1208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EUWvC2ZmH411jHMcGT3kDJDAypGP3emodkIt33fJvUpJrNIqAoHb0gg0f5PNkj7zb/BoXtQexjtm+6mNpE5J6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB9261
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
	TAGGED_FROM(0.00)[bounces-9025-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:mid,garyguo.net:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,forlt:email]
X-Rspamd-Queue-Id: C479E582B9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun May 17, 2026 at 1:01 AM BST, Danilo Krummrich wrote:
> Generalize Registration<T> to Registration<F: ForLt> and
> Device::registration_data<F: ForLt>() to return Pin<&F::Of<'_>>.
>
> The stored 'static lifetime is shortened to the borrow lifetime of &self
> via ForLt::cast_ref; ForLt's covariance guarantee makes this sound.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  drivers/gpu/nova-core/driver.rs       |  4 +-
>  rust/kernel/auxiliary.rs              | 68 +++++++++++++++++----------
>  samples/rust/rust_driver_auxiliary.rs |  8 ++--
>  3 files changed, 52 insertions(+), 28 deletions(-)
>
> [snip]
>
> @@ -389,43 +399,51 @@ struct RegistrationData<T> {
>  /// This type represents the registration of a [`struct auxiliary_device=
`]. When its parent device
>  /// is unbound, the corresponding auxiliary device will be unregistered =
from the system.
>  ///
> -/// The type parameter `T` is the type of the registration data owned by=
 the registering (parent)
> -/// driver. It can be accessed by the auxiliary driver through
> -/// [`Device::registration_data()`].
> +/// The type parameter `F` is a [`ForLt`](trait@ForLt) encoding of the r=
egistration
> +/// data type. For non-lifetime-parameterized types, use [`ForLt!(T)`](m=
acro@ForLt).
> +/// The data can be accessed by the auxiliary driver through [`Device::r=
egistration_data()`].
>  ///
>  /// # Invariants
>  ///
>  /// `self.adev` always holds a valid pointer to an initialized and regis=
tered
>  /// [`struct auxiliary_device`] whose `registration_data_rust` field poi=
nts to a
> -/// valid `Pin<KBox<RegistrationData<T>>>`.
> -pub struct Registration<T: 'static> {
> +/// valid `Pin<KBox<RegistrationData<F::Of<'static>>>>`.
> +pub struct Registration<F: ForLt> {
>      adev: NonNull<bindings::auxiliary_device>,
> -    _data: PhantomData<T>,
> +    _data: PhantomData<F>,
>  }
> =20
> -impl<T: Send + Sync + 'static> Registration<T> {
> +impl<F: ForLt> Registration<F>
> +where
> +    for<'a> F::Of<'a>: Send + Sync,
> +{
>      /// Create and register a new auxiliary device with the given regist=
ration data.
>      ///
>      /// The `data` is owned by the registration and can be accessed thro=
ugh the auxiliary device
>      /// via [`Device::registration_data()`].
> -    pub fn new<E>(
> -        parent: &device::Device<device::Bound>,
> +    pub fn new<'bound, E>(
> +        parent: &'bound device::Device<device::Bound>,
>          name: &CStr,
>          id: u32,
>          modname: &CStr,
> -        data: impl PinInit<T, E>,
> +        data: impl PinInit<F::Of<'bound>, E>,
>      ) -> Result<Devres<Self>>

I think this is unsound for the reason that I gave in another email
https://lore.kernel.org/rust-for-linux/DIMSJVKTYX6D.AEN6OPPC2898@garyguo.ne=
t/.

Best,
Gary

>      where
>          Error: From<E>,
>      {
>          let data =3D KBox::pin_init::<Error>(
>              try_pin_init!(RegistrationData {
> -                type_id: TypeId::of::<T>(),
> +                type_id: TypeId::of::<F::Of<'static>>(),
>                  data <- data,
>              }),
>              GFP_KERNEL,
>          )?;
> =20
> +        // SAFETY: Lifetimes are erased and do not affect layout, so Reg=
istrationData<F::Of<'bound>>
> +        // and RegistrationData<F::Of<'static>> have identical represent=
ation.
> +        let data: Pin<KBox<RegistrationData<F::Of<'static>>>> =3D
> +            unsafe { core::mem::transmute(data) };
> +
>          let boxed: KBox<Opaque<bindings::auxiliary_device>> =3D KBox::ze=
roed(GFP_KERNEL)?;
>          let adev =3D boxed.get();
> =20
> @@ -455,7 +473,9 @@ pub fn new<E>(
>          if ret !=3D 0 {
>              // SAFETY: `registration_data` was set above via `into_forei=
gn()`.
>              drop(unsafe {
> -                Pin::<KBox<RegistrationData<T>>>::from_foreign((*adev).r=
egistration_data_rust)
> +                Pin::<KBox<RegistrationData<F::Of<'static>>>>::from_fore=
ign(
> +                    (*adev).registration_data_rust,
> +                )
>              });
> =20
>              // SAFETY: `adev` is guaranteed to be a valid pointer to a
> @@ -478,7 +498,7 @@ pub fn new<E>(
>      }
>  }

