Return-Path: <linux-pwm+bounces-9097-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AA/fKCTSE2qnGQcAu9opvQ
	(envelope-from <linux-pwm+bounces-9097-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 06:37:56 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F375C5B28
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 06:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29CA23008D3C
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 04:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38FB30C17E;
	Mon, 25 May 2026 04:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F/NQclfD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010016.outbound.protection.outlook.com [52.101.61.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1C62C0F81;
	Mon, 25 May 2026 04:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779683873; cv=fail; b=ddFP/asWmPsSWGiXWoP/tuJRVIP0F1YifsTjICJ0CpXgFZOZHe+QLt/EnfHtZ817Qm7nyLQL9/7zKSB8WzGQm/vQLsW3JIYS/afYzeWNpZ+/q6ZXF5PMBk4KlcVmOWDtkGPpCGPKL85NVa0zp+d+0dff+aKJ7aZ1/8286K4r3LY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779683873; c=relaxed/simple;
	bh=hsA40JxqhFYvn3WdZ4znQgLP3/Oh3XxJbsmMaBNRHRM=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=SLjDcBPLeadaZVOTU2FI8Y+VKrEDygL8KsEgHjkrKnLioYn4qzeD1kdcqjmGk1+isFMP18XwMfD1Pw4j2TqRcx9+e3Z4oQraFtnRtKx975gjjBXiKEXIBTGv/CIJOEE5vCBZRTbgSltwbCGyRgKd95A4IZdyVzUMIJfRh1LbN1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F/NQclfD; arc=fail smtp.client-ip=52.101.61.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=acBeg/HQpC2oKkHO0W/Tfy0MFQYlkvQDxHGXCd/d0xMAaxFQaZIns13EcitN2yKknb1xd2wAhXs2vzXZVk7lL4X6JR/m7lS8mVNh2HpecCxERE6PcXbYdqwznZ+gHKw9FxgTOQNrrIEXP79LzRapcH/md8YzeFFroDfuDBL1FZnq4zNKLurM2elbK/VumJB1Q0c1knXUtcammQxXK1kNpkjjiPJeWrlDHkXPa1ZFKzr9gIpedae8tH7BFtv+IKyKomW+MbRbqTMGJ4ePVL/ErImf30Y1pnAnmiWDAjtqcgWmUU8TF66MMU6ftiD5m7bobykIozwkBLGOr4ovzTktlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frEGq2bPXrX5lnbWAUk9yX8qOUydSxnX6SFVc3J2UoE=;
 b=DDM/xl5IBQniP+N7kfKOMEdNK1AMIqQVV0udig1urI6yrkxdsBR3PyofzalT6vHjbKnmonDyJzn2CETUA7oLHDFd+II1R8nY6N0JI0oVmAJqx0iH9wDSl4iLK29u9bHXvrymBn8tzf6C9c25l7aiYdGGMClY1H22UFi6dUjuYMxE0j4PlwJ/QIF+INdpnP5T8/xjYg/OIDzhrnuQ4ngmR40guSNanQNroETW95a5WvDfIv6d7K4WX/noYoc3oerx0M5DxbyeA60vsvV9hpBLTYnHRSrxYGlMldDSru9+0GOjjOHyr8h1KE62Tu2TmZcKW6zJg5iu8Q8nm4P0wprjiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frEGq2bPXrX5lnbWAUk9yX8qOUydSxnX6SFVc3J2UoE=;
 b=F/NQclfDHG7Lgxcn7oqFNkjyFZsNw5Qhi6o58idVKs5m/i0FN3ymVdOP2SKl9tVi7cJc5zJaiSff3E0kiGIGqAK2OYe24gzO+h7voq2OM8O6tM2pwpiNRdSXcHP7jNmngNmKYGuZOUKojgOmCEDAOwgCIbfEhrr6PYHiaMxObnQvAbjnmELsNlDI20sFn/Xov6dqMbOh+2OTv6fNJ/oVlBGdUSUIcL63PAvP+XK2Iao+1qbKzbx3LRX2ShSqP8RJSuP7z1w2351CR/EGrhXBKflO6qd61d84YMfql685wn72OB5CyLSWwlVDNsfZE0J6OeLBXOaotHBGuje9QOB0cQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SA1PR12MB999251.namprd12.prod.outlook.com (2603:10b6:806:4dd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 04:37:48 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 04:37:48 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 May 2026 13:37:43 +0900
Message-Id: <DIRHA02BRA92.32YSMYYL2QBIG@nvidia.com>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Eliot
 Courtney" <ecourtney@nvidia.com>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v4 17/27] rust: pci: make Bar lifetime-parameterized
From: "Eliot Courtney" <ecourtney@nvidia.com>
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
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260521233501.1191842-1-dakr@kernel.org>
 <20260521233501.1191842-18-dakr@kernel.org>
In-Reply-To: <20260521233501.1191842-18-dakr@kernel.org>
X-ClientProxiedBy: TYCPR01CA0196.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::20) To SN1PR12MB2368.namprd12.prod.outlook.com
 (2603:10b6:802:32::23)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SA1PR12MB999251:EE_
X-MS-Office365-Filtering-Correlation-Id: e099bf40-9a50-4312-55b4-08deba175eba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014|921020|4143699003|56012099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	vdARJoGWLJaagg3COexwzafd37c9YcbJs6R4VBh473TkR/1frmk9gi2DNHhza7j3hSbTCbm+hHEW+NX7hSAhuWJElkDHTMU88eUYo0GIYa+uYe7iGMUAC8wt2Gt3bOl4YjlbFQNX8XboIlyJ3L/iYXxJ77D51SQVSH0sgIAeuMJzNhX/C4DNET6tfmhv5LVtJcBRv9wMo9WsmgQTf7D0fN4ZPSuYk9SCIMDelPKtFd12g+dBJx5UV0w1oduzGcaVR10LrKUnhWLzBuYqRvfE6A174CBkYR/QqD6fknjtepUARd1IBqu5o/r2m3J+n/CuDarDqLT0pnOpJJF7Mcc1LWj35dC0GCfRrezN56ln6CXC+jmxGjmTQVagYo2Tx/BIGw17Z7LF2uSVj22i3vNqC6euj8EOHTGpHiOgMiX/THrcDBdyEPIOplBJZ8oIbI6Eyp6+TgkVoUxAY0GLdH5oKf3snj09NdflhmT/tj05dffJFuvA6RNJdZifHJsi8L9WqG06fsEAHKGuoPSlWP3yrX1mGfdNn+JjwHswDjBILhIlpAYf8JvlPR7OOraPDlKY6p9KXoAlUnaMPY7h81vs+iqHtFYBRDffNZM6vleOWgynxD9Pbst4lJbn1w8IeM6YWb9C3iMbhSKt7SKMcpFIsRV79ZizdBDb53vQzwAF1Dw04ZwcZy5sJ3EX290yxZBn+9GO0D5BMSaZD6pRucwyZaEB9wVslFMLWCD719DOPxk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2353.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(921020)(4143699003)(56012099003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVZJbjVnRTM1dVdEZHhuOFQxSU1QNXZDcVVFaWQ3WTlGNnA2R2tFTlpkWk9F?=
 =?utf-8?B?REFBVWVvZkVoTmFkWWsxdFkrcFVvL3p2M0phUHhQalFTUWRHYldBb2k0R2Vk?=
 =?utf-8?B?K0lGWTFRVERERUtFMEtKYTF4OVZQVVZSUmk0c3N0ZXcyMThVM0FHRkEvbGpJ?=
 =?utf-8?B?QXBzK01pc1F2VkJGTGg3eHpleVRLRzR2a1FpSEMvMXVlOWpWZnpFSTdpb1Zy?=
 =?utf-8?B?YTNhOVVVSHo3aTJ3eXQwS3R0YWM3SWhxdFJhRjI0WmFNdy9sS0tTWUdJeFdx?=
 =?utf-8?B?MUhrSDBFeUFTMVluZnF0L3BEcHlnUkZ6ZlBZd200RUZadkJkMk9kZGhWOHAw?=
 =?utf-8?B?TFJPbENEZjBmZ2UvNTlJU29kS09BMDd5Z3FVTEhIVFNlM3I4bFVqeVltM3ov?=
 =?utf-8?B?WDI0cVozemhqekV0T3N2cDRGWnB4OXpWOHQ1dkd0Nm16ZUJxZlppTUVzencw?=
 =?utf-8?B?Q0FvUWVtVndwNWljai9rNlc0QnEzVGhRcDNTRnI0K0RicHBTeXVWS1YvUDda?=
 =?utf-8?B?Tk81MzJlSDdJU05rWHhrckpadDA4cnJHVVRJMEtNdER1d0JhZzQycWFacy9L?=
 =?utf-8?B?ZFU5a3NUQSswbXhTR01NMjhSc01IUFZvaFlZK2s3emVHSVl6MkQ1NTZXOUM0?=
 =?utf-8?B?TG5TMXMwQlJLZTJWcWVXeGhselB5bmlUZlpQbFlEWTJhSGo5ZjZuSEp2Nndo?=
 =?utf-8?B?TGFWU1gxOVZpT3RXKzFZdG1qUUxUWG9KT1JlaGgrMGxuWGR6Ky9qanpKVWN3?=
 =?utf-8?B?R1pPTnB5Y2JHcEJpck5wNUNHRUV5MzVQOXE4TGJJTENSbjVtY1lGZ0ltOFlt?=
 =?utf-8?B?bElDcTd6S2s2NlBKZTRKcGZ4elBpMmlhNEx0M2xKRjR3VVZNc284aXFobzlT?=
 =?utf-8?B?R0QrRUNhYjNNMDFOcUg5Vzh4anpnVzkwYkhkZGdPZDR1d3dGVHk3QnFFNVpl?=
 =?utf-8?B?M0VWcnBVVVllYnJ4QlNpUys1WGRwTW5pcmJwNjVhbHlEOGFqcG0yZm44YXBP?=
 =?utf-8?B?NDB3bUpRSStydi9FOHZuSU45dUxhdGdTV2RHSGtZOXV5THo5cWxUTzdjN1Jz?=
 =?utf-8?B?eE1lamZteWJ5QlRpNWx0cVhWclN5cDhjOUprSlNvOWdMenQ4WUNNYjgrdUJX?=
 =?utf-8?B?ZDJKRzgzQjV2ak55aGhZRllPN09lampPTHQ4WXkySW9VT0hNNkhwcHBRUFZF?=
 =?utf-8?B?cDJocXAzWG9jNStKRlJPQ0c2K3o4V2pJV3RPOE1ndjB0dmM4THhWeVpjQ2ts?=
 =?utf-8?B?d1FsY1o2V29QaFh6blF6dU1heFZyYzV0OFJ0c0hobXJacXFCbkRtUklHUmZl?=
 =?utf-8?B?K0w2TTlGTlljTC9jMWpobDM4MjkyZS82YjdHbFNFcG83Z1Rod2NPdEl5TnpF?=
 =?utf-8?B?ZVVaTVE2S2hhMFZrMUdOT3BpMGgvamRadEJPanNyaGdpd1g1NmFRb1UzQ0la?=
 =?utf-8?B?STJqaHVGMEZtQ2E2UHlkOFg5bTg0bXdMelhpUHI0Y21XaWJoL1EvZDlnbE1R?=
 =?utf-8?B?VE1GZENQdi9adWJRZWdzejc4WEFUSEFFTjBoNU5mSklxUjMzM3crSmVjYVBi?=
 =?utf-8?B?bGVWSXVTanZ2Vk04Mzd6ZFJFR1ljOUdtYktLdjZJOFFDUTQ0dHZIZmpzYTk2?=
 =?utf-8?B?cWgvNEozcUFtOHRIUmV3UnpmVysyTXM0ZExwbUFLTjFZSVBaUFFNaloxYlZV?=
 =?utf-8?B?ajdSem1oOGF1NElmaUJpY1ltdGdRUldqUUt3QzlTNW1VZGxwemRnSVExUENr?=
 =?utf-8?B?VjZJRlVTaURtY2FSWVpnNUlKOER3eWdDbzR0U0c2Q2prQWVKVUNEYUdPMHlH?=
 =?utf-8?B?VjZNbEpSK3NpUlRYSXZ1bnVGalEwTWhGdmNNVWlsbFZRTFBFZFFlbTdjc2ZT?=
 =?utf-8?B?MWc2SFBsNlFIRTZqRDhidTJXWnNWMExOT0NSdUwwQUozOWtCazVmaFVuSHhC?=
 =?utf-8?B?aWFQeUFZUTlZdlJ3SU1pV1krT2JCaXhwN29uR3pqMUtSeWc0V2pEKzh5emZo?=
 =?utf-8?B?RWdOTU9NdmVnWWR0UkZES3hlY05XdGFabFRNNFR5d09NUGYvMTROUTRxQzFD?=
 =?utf-8?B?VTZJdHJBRyt2alZtaXRKOEg3M3dvajhRc2tvbCt0aU43SFVmdFJISlNpamNl?=
 =?utf-8?B?RXVseWlIRndhN3JnMSthaEdTbTZMeit6OHdpR0dwTXEzKy9XME1ydXI3OWg0?=
 =?utf-8?B?WldnYkt3WEhWVUo2SXFNR2RaR3d0eFhYQk9CRWtWVDJ1L0V4dUc1bkRyQWk2?=
 =?utf-8?B?MkVQeFlySUh0cnRTc1V1TkJNRDZ4bFNyL0IvcHZqMVc5Wnl0Y0FldFFhemVp?=
 =?utf-8?B?WEtXcklGeEk1V0ZKblZKMWprMy94dVN5dXdRcHA1NE9BbmQrRGpwMG5IWEhu?=
 =?utf-8?Q?hzTjaL52RzfRs8me1xvMmuNoU6Uq6skDE7oOsRyNMn6zw?=
X-MS-Exchange-AntiSpam-MessageData-1: miIp37mO1nZQTA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e099bf40-9a50-4312-55b4-08deba175eba
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 04:37:48.8011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1XzXsgOdHZbRZmswhnereD/9MDbf1w8oVIlmteFvwf9aKSKBt6kr2Y1Np8/JxCeaC+3qC6BRpZ2YijC4TFsMLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999251
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9097-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ecourtney@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: E5F375C5B28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri May 22, 2026 at 8:34 AM JST, Danilo Krummrich wrote:
> Convert pci::Bar<SIZE> to pci::Bar<'a, SIZE>, storing &'a Device<Bound>
> to tie the BAR mapping lifetime to the device.
>
> iomap_region_sized() now returns Result<Bar<'a, SIZE>> directly instead
> of impl PinInit<Devres<Bar<SIZE>>, Error>.
>
> Add Bar::into_devres() to consume the bar and register it as a
> device-managed resource, returning Devres<Bar<'static, SIZE>>. The
> lifetime is erased to 'static because Devres guarantees the bar does not
> actually outlive the device -- access is revoked on unbind.
>
> Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  drivers/gpu/nova-core/driver.rs |  7 +++--
>  rust/kernel/devres.rs           |  2 +-
>  rust/kernel/pci/io.rs           | 50 ++++++++++++++++++---------------
>  samples/rust/rust_driver_pci.rs |  5 ++--
>  4 files changed, 35 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driv=
er.rs
> index 6ad1a856694c..7dbec0470c26 100644
> --- a/drivers/gpu/nova-core/driver.rs
> +++ b/drivers/gpu/nova-core/driver.rs
> @@ -45,7 +45,7 @@ pub(crate) struct NovaCore {
>  // DMA addresses. These systems should be quite rare.
>  const GPU_DMA_BITS: u32 =3D 47;
> =20
> -pub(crate) type Bar0 =3D pci::Bar<BAR0_SIZE>;
> +pub(crate) type Bar0 =3D pci::Bar<'static, BAR0_SIZE>;
> =20
>  kernel::pci_device_table!(
>      PCI_TABLE,
> @@ -92,8 +92,9 @@ fn probe<'bound>(
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
> index fd4633f977f6..82cbd8b969fb 100644
> --- a/rust/kernel/devres.rs
> +++ b/rust/kernel/devres.rs
> @@ -304,7 +304,7 @@ pub fn device(&self) -> &Device {
>      ///     pci, //
>      /// };
>      ///
> -    /// fn from_core(dev: &pci::Device<Core<'_>>, devres: Devres<pci::Ba=
r<0x4>>) -> Result {
> +    /// fn from_core(dev: &pci::Device<Core<'_>>, devres: Devres<pci::Ba=
r<'_, 0x4>>) -> Result {
>      ///     let bar =3D devres.access(dev.as_ref())?;
>      ///
>      ///     let _ =3D bar.read32(0x0);
> diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
> index ae78676c927f..6116c55412bc 100644
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
> @@ -146,14 +145,14 @@ impl<'a, S: ConfigSpaceKind> IoKnownSize for Config=
Space<'a, S> {
>  ///
>  /// `Bar` always holds an `IoRaw` instance that holds a valid pointer to=
 the start of the I/O
>  /// memory mapped PCI BAR and its size.
> -pub struct Bar<const SIZE: usize =3D 0> {
> -    pdev: ARef<Device>,
> +pub struct Bar<'a, const SIZE: usize =3D 0> {
> +    pdev: &'a Device<device::Bound>,
>      io: MmioRaw<SIZE>,
>      num: i32,
>  }
> =20
> -impl<const SIZE: usize> Bar<SIZE> {
> -    pub(super) fn new(pdev: &Device, num: u32, name: &CStr) -> Result<Se=
lf> {
> +impl<'a, const SIZE: usize> Bar<'a, SIZE> {
> +    pub(super) fn new(pdev: &'a Device<device::Bound>, num: u32, name: &=
CStr) -> Result<Self> {

I think Sashiko's comment w.r.t. &CStrs in this patch looks accurate
and they should be 'static or at least 'a ish.

still
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>


