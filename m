Return-Path: <linux-pwm+bounces-9528-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x+zzAK/CR2p9ewAAu9opvQ
	(envelope-from <linux-pwm+bounces-9528-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 16:09:51 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A3770344D
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 16:09:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=QmDknQ17;
	dmarc=pass (policy=none) header.from=garyguo.net;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9528-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9528-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F207E3201C3F
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2026 13:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1221E3F4138;
	Fri,  3 Jul 2026 13:49:16 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021090.outbound.protection.outlook.com [52.101.100.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C6B3DA7F9;
	Fri,  3 Jul 2026 13:49:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086556; cv=fail; b=h3cFTwUW+N/bvpvKM+HT167FecGdlZJK7cYH/8hs+t9QmrV6/SprLOJwneezn8blNb3dG22j5evO4f8AhsbZ5vmZyJ1NTCJkGbuBtawdHpEYl5Ud0VQ43IMmWc9mn6ruR5qLBKv8xeW1ju0G0d3PJyIROtnGNq8QqvhuUjLZDNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086556; c=relaxed/simple;
	bh=XE2UWc21CsIIU4gzwmimWMHQSObOt5nHJ3g0Kdd4K/Y=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=aMz1cxvnzFzby9/YaoXCZb/1sg3E08uf/FwXnZacXvumMsOCjLjsy3/wYosdxXhrkE/0fVTXJBomznbL7K6IyZA9SyuleEGqeKxUZKbDEw2+OvpwduJ+BemY01CXPihxBaZTt4tEDRbP8G23cXmToW6f3K0NYJRa10MJDA5AljU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=QmDknQ17; arc=fail smtp.client-ip=52.101.100.90
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ae3YQ1iAqpqxVvvLNMpWVylBZyKiSZEmC0GqKCl3RG/DTXWc4DSGfpHDQEtjyqptVUUHZ23wJXZx6M5GiFjZq6RtJSh03Gqqucv3SEvQJrNgVBQpCv2WNH9HhBYchGzPeAABgx/ucSq+5jDozbvOR4rBrUyemiayWKNtKw8QeswQoD0gIyQGNoMPtxpOhT84hG9fuIdxffe3cLIhnXtSYE97LaXdIHu0SlN90tSTbvbU1Q8t5mjbJSNuj5skEOdtgX/Lj3R3sgUEHi+qkw/yzzdxBVi5M69roiNd6L1Qwwyk+bEBGPzeeZSeSyizHQNn/khsO1IOODX6dL88I/amYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsBRoIppRmpwjgb+RI60o1TEy8QDLLcilB1Bhkp5tAc=;
 b=FdKL/ghp9wN7QmN2sDVlcY+hnd5czzVNuEGJkkD2ps75oA+Rkb7xYuseaaGh/7EGtSkCbVKSEUuCbNwxh4mvrZq2lfEwsQZcXZkfq1U6pptYOpqmCBgCC50lYEaJTVjU1afPjv3mMLbnDu6GHWoWodsvOnt39EcOJaJWliYB6wpHoSFjCG20Y5/cFo2TvrR5Ejpnw5QFsVEuJTVeiHw7N3cHMTqeUvE0BmTrw0fkOtjkiwSJgZX+YZPUuX2Pq54t/FsMaT8b6OnWnlaVwCmmc0TBR4Gfybq3cdhW2MvQKfRm0TO7wJr/V9Wc2bC2ziKhLRlGyhLbYyD8HXNlIhrbIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsBRoIppRmpwjgb+RI60o1TEy8QDLLcilB1Bhkp5tAc=;
 b=QmDknQ17qmiND1nzgUmPARLQR6GGVIhlFI3YNsxHFPZ4CFz98/7MBNhvcVAcF3zEToont88JcGbOqtmguGUwPGUDEvk0Zy1RW1Qw/WURluNK16HNUobfp/JRJQqjJY5c50yw9GPDMdyJWU1pWtFnY6RLhJyrLEoDUdxBrIi22wo=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOZP265MB8524.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Fri, 3 Jul
 2026 13:49:09 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 13:49:09 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 14:49:09 +0100
Message-Id: <DJOZFG9XDNYV.1Z0BXKIODDTAF@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Abdiel Janulgue" <abdiel.janulgue@gmail.com>,
 "Robin Murphy" <robin.murphy@arm.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Michal Wilczynski"
 <m.wilczynski@samsung.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v5 02/20] rust: io: add missing safety requirement in
 `IoCapable` methods
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-2-d0961471ae50@garyguo.net>
 <DJOLKP1V1IDU.1GWHOHBG9CS7@nvidia.com>
 <DJOXUW6ODKCI.1GLNDU00TDJWU@garyguo.net>
 <DJOYL5QPEM76.1N99BVDVHB8VS@nvidia.com>
In-Reply-To: <DJOYL5QPEM76.1N99BVDVHB8VS@nvidia.com>
X-ClientProxiedBy: LO6P265CA0013.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::19) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOZP265MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: 37d00854-6bec-46b0-fff1-08ded909db9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|10070799003|366016|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	se+3Nq3/8+wXihzG/8vN2ywfibbJ+fq0PFfT8nWkOvmkmc0nVNQ7eDWhk14r3TLgVClicknLFW0xl++abv669ZRRiRfVooCUM4AafXkUKM2TmWXdJsmR7pYGIt8PfUuvkmYrZZa8jKQWpG59p0Q8I2GIGTcTcU08wm8T7bLCOeqt83AfPrZZjJRGLrvneQME2CFJwfW+zjAOD/LJDInfp18NsnNRVwuK+/iGr+1qPe3bggtrSsdo0S2dN1+Gi3b/bXysApZsWROiPTWfWzlqQYxU+bficMhoiuzfs4DXMD6mFDJOVdh8ML7oOdFyDBhhii+m5BG1xOJ8dgUeVNWn/DSHlLXXXvFK7MMbe0K4WgbHhiO7drjBWfYq/8+leOUfZGyyQLoVCjH2TFXPPgmoZaXRPO2rIXVa59g0oCua/YqmuV1ZtzWAWUt3fwFKMuYdzn41qbHBHgonQri1rX9+zQuMpZDS14zewESYVbWdgmzbMHwSkNsY6XTgR0eNbbrJ/AhRUOS0B/zZzZX4EiJvD71qlem/k4scVQF0ChP44OqGHmIZp/5UV1nOsFGZL1mR6F8rqEIUn+4BLdbdyYZQGteypa5XLdZepNaE8unbTShr9TeGKh26Jzj147HJ1I6N+FDh0mbvmnhn1tue1S+beitrezEdJXbo0/ktqO2dfco=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(10070799003)(366016)(22082099003)(18002099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SCtycVVva2JuYUwwMlJiNWM2NDBVT3pyU2pHTmxGZWFxK2t2dW10Z0FTd29y?=
 =?utf-8?B?dzRtM2lqMU9XTktWdmFoZmhTWVhtdHN4Wm0vNmJ4MXlrRUVYbDlZV0RlSjJ2?=
 =?utf-8?B?bFUxR2hrSGN4NWlJU2Fjdm9iWVR0TmhhbnFTa2hRZDk1aEY2UytuUUVWOFdt?=
 =?utf-8?B?cVdqLzBmSjRGUW9NU0dlQ0pMRDhDb1VDNC9wTWZjbVFmTG4zcGhCMkJoclVO?=
 =?utf-8?B?VkVxZGN6SmM2SnBiV1ZWUVVaeVk5NklyKy9lYXpyc3VQM3R0QjJ1VmhqTW04?=
 =?utf-8?B?QmYwQjhxYlBnZzA2b1ZJL29HREZ0VzVFWkpycU1zb1N4YnhBSzBrcU1kZk0x?=
 =?utf-8?B?K3g1NU02REtnMk91czRmWkhCYnhQOHNoMTQ1OEJEd05oOGRjdWJiSVhCL1ZF?=
 =?utf-8?B?WlZUVFVnZkNqRTZTUVdOUm0wRC9yaWM0SmMxQk5BVHpNRG55T1pxb1pweHVQ?=
 =?utf-8?B?a3h6dFB6ZERMcTZhUnJiejRaUUtpMi9JU2NYV0M4RWVqakc1b0JBSVRGbkk3?=
 =?utf-8?B?Nm5zMzRrRjROTU9YS3g0NG01U21hcHlscXNjVlNaUXM2Q0RjdU9ZMFA4NmNh?=
 =?utf-8?B?WFhDUlFIMml0RUo1ZzIvZ25kTG95bk9LMDNNTXh3b2p1dzZqcHdhYWdOd2dO?=
 =?utf-8?B?WkQ3VTROOXFsNmNodWV5TGwvNGcyUkVnRU1STFRhRm9QSU5ydzhaQmtVb2Zv?=
 =?utf-8?B?TVN4bitNdFRRL3plL0NneENnUHdETDJGZ3ZwQkNldGhmcGFJZGlVY2tEL0cy?=
 =?utf-8?B?d2MzRXY5ckhGK3JFZWphdlBTYW53VHBXOGlZVjhjQ1Z2UThYUGhkYUtFMFc1?=
 =?utf-8?B?L0JRR3ZrbGJ3ZWJKN2FrUmFjd0UzNURKdE4xdmdSaEp0NThrTlIzMFJROTd6?=
 =?utf-8?B?SnZ4ZEZ0dkk5b09zUUp5N0tzRkRKTGpNQzQ5SWFjOEp1bzFYWlc4UmVmeE1n?=
 =?utf-8?B?bFZEVk9UdCtmUVJvYmtLd1dBZ3dNdmN1OWlBMTZwbzhHeHg5MGRua1IwQWFx?=
 =?utf-8?B?Zk5NL2Q0cVBmQjN0bEhEcVFERDRBRWk2ZlY4aTFodjBIT3lBQUhWbjdYcDlE?=
 =?utf-8?B?OG03ZUlHODhzd24xcitzR0xERjZjeFJPNkVPbGdUN2VZanhGUGkySlRUNnZD?=
 =?utf-8?B?REdHZjBBMFlKSFRvR1dDWGJYa2xET1MvajNNWUpTalZvV1FXSUROOFZjcWtV?=
 =?utf-8?B?SytncmFRTjMvaTVuSlUrVWlqSDV4bkxCTklGN3pDSm55SDZhbkVqakVYYVRH?=
 =?utf-8?B?WmlLN3U4NmdydmdFYXo2K1NySmZYZEx3ck9LMXNRVE9XMVdyZnJuYm9tZko5?=
 =?utf-8?B?NHByVDQxUHdLRSsrbW1rZFR6cXhJb01POGlISUpyaVJLei9vaHorQlVIM2pG?=
 =?utf-8?B?ZEQ5aHQ1OWN2MnAzMVRwRk91QU1BMXk4QW1KKzVvSlNGS2d5d29LYUUxSjBP?=
 =?utf-8?B?WHJXbk4zZFZVUVljSWlpMm1WQW44NjlOU2xNK05nM0d4NEFjUElPNElLb1ZJ?=
 =?utf-8?B?QXlFY1AwWXFRdnFwYmRjK1lQU3NoT2k5c1grTUpmdy9lYUppMDE3TDVTN0NM?=
 =?utf-8?B?eEJBTC9LNHAxeC9BSm5jRW04YXJHSkh4b0hKdENuTzlOWU9mUkY1Y0gwT0Nn?=
 =?utf-8?B?S1ZzREw2SFVBZldjSEZhRUY2OTB5eXJTOUo0Y2ZTWnhrR3dVQWN0bU40SGZF?=
 =?utf-8?B?cDRDd2t0K0l6ZTdSVUtFVVpGLzMvOU9JL1VPVG1CM3I0SkpXUmtCcmVqaE5P?=
 =?utf-8?B?OVlmK3VvdGlDVzR1WE9KaDVHUjJrZ3hIOGZ5UncvRlQ3eGtZbjF4WkZacUZs?=
 =?utf-8?B?c1NETnFmd1NBQm50VENvN2xxaTQ1M3BDTEFUcjVJTGVkcDBuQTN3WkI1eDdo?=
 =?utf-8?B?YUJjNmo0RGpra2U0b2luNGlzeENFTms2SVh3VENkQ2pxSUo5bTA0NnhhdlFD?=
 =?utf-8?B?ZDFYanUrQkFBT081d1BxUVlJUEZvMEZaY1c2K0pqZmdtSk9vQTlicEYvQU5h?=
 =?utf-8?B?YlNuR3ByNittK0pBWTVpcTRPZTlOZkc0WlhIODgxdk41VzZVdDBLeVhlVTFX?=
 =?utf-8?B?Njc2WGYxU0t5dUp6S3loZW80cUpnK1lzSjNYWHlqQUdKQXZ6NGhlSmEyTTZE?=
 =?utf-8?B?a2MycGpGTkxmbThpSmxJN0JrN24rWnFjbHF1YWorZkN5R1o1T00xNVk5Skhm?=
 =?utf-8?B?MktXOGZhMG9KbGg3RkxGM3RLNlNpRlVWVmZnOHJldjZKY2l6YWl2ajd4M0tX?=
 =?utf-8?B?VWtrUmVCdFNpVWFsd3ArdEhBcTQxTlJ3MjZwMGh1YnFJNWE3KzVlUGx4bGpW?=
 =?utf-8?B?N251b2ZnM3A4YmpjV3VXVEY0eSs5U21YbUIxR2dvUU5McFFONkludz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d00854-6bec-46b0-fff1-08ded909db9e
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 13:49:09.6568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9AOJNi9cySPkT0WYOzL6LiIuk6Ax8zKLe8mGKT5wn4TMcek6FpNldMsk8OlgX3h3Of1ttFCr5AmrdjwwbT+0Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOZP265MB8524
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9528-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[30];
	FORGED_RECIPIENTS(0.00)[m:acourbot@nvidia.com,m:gary@garyguo.net,m:aliceryhl@google.com,m:daniel.almeida@collabora.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[google.com,collabora.com,linuxfoundation.org,kernel.org,protonmail.com,umich.edu,onurozkan.dev,gmail.com,arm.com,ffwll.ch,samsung.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,garyguo.net:from_mime,garyguo.net:dkim,garyguo.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 94A3770344D

On Fri Jul 3, 2026 at 2:09 PM BST, Alexandre Courbot wrote:
> On Fri Jul 3, 2026 at 9:35 PM JST, Gary Guo wrote:
>> On Fri Jul 3, 2026 at 3:57 AM BST, Alexandre Courbot wrote:
>>> On Fri Jun 26, 2026 at 11:45 PM JST, Gary Guo wrote:
>>> <...>
>>>> @@ -309,7 +312,11 @@ pub trait Io {
>>>>      // Always inline to optimize out error path of `build_assert`.
>>>>      #[inline(always)]
>>>>      fn io_addr_assert<U>(&self, offset: usize) -> usize {
>>>> -        build_assert!(offset_valid::<U>(offset, Self::Target::MIN_SIZ=
E));
>>>> +        // We cannot check alignment with `offset_valid` using `self.=
addr()`. So set 0 for it and
>>>> +        // ensure alignment by checking that the alignment of `U` is =
smaller or equal to the
>>>> +        // alignment of `Self::Target`.
>>>> +        const_assert!(Alignment::of::<U>().as_usize() <=3D Self::Targ=
et::MIN_ALIGN.as_usize());
>>>
>>> With `Region::MIN_ALIGN` being `4`, my understanding is that this will
>>> make `read64` and other infallible 64-bit accessors unusable on untyped
>>> I/O regions?
>>
>> That's correct.
>
> Isn't that a limitation we may want to eventually address? The fallible
> accessors are still usable, but it seems arbitrary that the non-fallible
> ones stop at 32 bits...

It'd probably be solved by having typed regions. 32-bit is the most common
alignment for I/O memory, so that's chosen.

None of the existing Rust drivers require 64-bit accessors yet.

Best,
Gary

