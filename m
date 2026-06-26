Return-Path: <linux-pwm+bounces-9406-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ggDxFcmQPmp1IAkAu9opvQ
	(envelope-from <linux-pwm+bounces-9406-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 16:46:33 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6CE6CE15D
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 16:46:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=nNSuo6sW;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9406-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9406-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 22513301F1CA
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 14:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F4A3FA5F9;
	Fri, 26 Jun 2026 14:45:35 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020079.outbound.protection.outlook.com [52.101.196.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56543F9F26;
	Fri, 26 Jun 2026 14:45:28 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485134; cv=fail; b=tkf8Lk9BC5/ZV//Nw96JTlpVEKUSTPv7M9p0yOGAdRchLnsVIAX8S1LJ579kJx9FGC2Otmxn/IAuhc1nyAnGTtebHx2lVz71+jQhIuIUfww7sGJWaBCM1TYia56Nib/SPTaB+iYVGR8KtEeJZOAtbcY2/9BSMoAMv0Ao7d1F2Do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485134; c=relaxed/simple;
	bh=+muOjIpzmY8awapBnAXwqFhkIut1D502R+SWpNlqg6w=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=XTy/hrMJTz0q2naaH9VqapdQ/4hZZYD6uP8YR1GKkxwGZy5lH1eyMjGZjUzdgoKTXcYBmy/PjBanRG2CfwITf/x0dx9yXGuHEtDeVAsq7CGhCt6bIKPupj11OZ0aRun+2Gu0403C3lDXqDaTraHAY0zYdAyF47mzM4FRYiFRvLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=nNSuo6sW; arc=fail smtp.client-ip=52.101.196.79
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BAT/NwgWikIhEpXkgT5BetkrB5n9xK2t1EhRMkZReqww9r+e/2ipPDpMZr8XUxoGKXi3o24H+xv1tzoQ598/LDeNCez3pzHWYCioWe00lFL8rX704k5dSzaBnNl4APJZH41260YFXW2qRiOHqlYXsyLrUZ4lJudouBCZ88AwTvIsq0fqykP0dj/+H3maQdqMidSnc7UgHF+Yykv/Nmysqf+BKdxuXKQmh/zqXtsngIOygahVYY3Y4vK/P8YHO41cZNH4yawN1neMrvVw9YOFTb6i8AVKMdjabgrq0bYupBOZr3kAeiz0tRHsq+7jZbrx9QIRhEgcZkf8AuJggfA+rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OE0RMkfhw++rlUCNwVF+Cv2B+Nx+ivGc6kFSgTFDNtQ=;
 b=Gz8TU7/Cy0HA4K8unjeVq1ZuPijxJEXAIEP3UBMr1UarJrd7vnQvwO9Bg0XEfPa5++hgdeHaM80lP8t3EoAAY5YLWOtsR53jQZ00pxaYWwC+cN32s2w4kXKWhc7N2gesagUXm2zKYyHjVjjaLiUmn6VOU9cuMsU382c9xHDd3N8vjVT5F0+tMnqaMWAqEQbnt7E21fRJdMzvvT/U4mx1bgbKc+BliSwfmNOZeUBZ7QhRVENL1HwsvU0pG+Ifqb20gbGUIC35Cc7YnAuahFIvaeE3KnR4wB2BwO/Fwg0WpYdwMWgf6sVwBgmnvYbexjFmRHZYMXK/+E02kKapFVEfpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OE0RMkfhw++rlUCNwVF+Cv2B+Nx+ivGc6kFSgTFDNtQ=;
 b=nNSuo6sWtKUEjTErWwiDhnIIEUBKxA4B9mC02TeEs8IubdYDhFUqHfuP8ihnHA1ToVDcLCC0aSmwfFJmLAAl+zCqUusy01hmpQ3CQ7cNqHvIcdzjkH3itwMaWmBWKM18U9J90q6RY5cZ0nyV6Dq3Csy4ZEPzY2iiQotPGBpU+NU=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO6P265MB7248.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:341::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 14:45:17 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 14:45:17 +0000
From: Gary Guo <gary@garyguo.net>
Date: Fri, 26 Jun 2026 15:45:05 +0100
Subject: [PATCH v5 01/20] rust: io: add dynamically-sized `Region` type
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-io_projection-v5-1-d0961471ae50@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
In-Reply-To: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
To: Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782485116; l=17123;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=+muOjIpzmY8awapBnAXwqFhkIut1D502R+SWpNlqg6w=;
 b=tzKDiJd/Uj3hXkttaj2sLxMQlN0WMOi/NDqcQEyNKlqUq5cyvuqD5U8KxyMqepHU05AijzRjm
 JA05rH4Hqw6A3Iud2g7S3BS/ODcNqvqaIY0GAaxxQmbeB3kZs59bJzi
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO6P265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::7) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO6P265MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: 900d66a5-100f-4b74-3752-08ded3918a36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|23010399003|366016|7416014|18002099003|22082099003|921020|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	t6K8L2s3qczXSBN5/iDEVYqORPeqvSmo3aLy+eCckx+iNc+k2qKLTuaPlp/D75FOLiH0A4kdf2FNHRMi5oRcDys6fkJhUtDv+qwrcPpg3ti6RrHHuXW1FGbK3IB+w39iQyT5t3HIacO+s1Sq8hd3WNL9XNTWCmtRgDOx5KG0D4VWJTlVHhOWIfsZau6gsd7RIR+kj6PgwFCCrS54UVLF6Sy/HBh1h6klD91rDMX3jRbPmDmDULm0kjbLEw6PAe0bUKeetiCyOU6Ya2TKO7wB2703pSJDBcBS9UnTpcn5a/Mmxx0zeHdySm6PdtQOJU/0YKeCxFq8j7IfXltMLvKMIwNOSBChHU1YufpccFSWMLhpicTvX2OhDjOt5E7bCtJM4VJ1Z4hCYByRwJlkrD4KQkNUGSd3NZ9DQTVgL7l15p5iJaDlsDcQjmEOQIlgF4dihiGTPHIyPYBVGmhkqzUye9ROwNCZ5vBdED1Ug/DzvhvQ2w5cyQ0vprfN5dQtFHYduqklZ/ih1kmS6qO/lqxkVBhL3TyCPEHk9N7qTYFYrBAbxIPMtgckJ4uFxD+Z8+09mJ1b7a2DmgAj+pET2h41pYzQa07kPZ5aQVcgYGZ8ODBgdx5Ij4+MH0tcd0VA6DVqTIcmHugIGy/lxEe7BFOb0w0HdfMgcZSRsOuo4buK9/OuThp1g8ngO2EFrrZoEPM7kK6Li+XKpvRCV7KCWOfI4g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(23010399003)(366016)(7416014)(18002099003)(22082099003)(921020)(5023799004)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFlLNzJxM1VIQUdWcnY5WS9FRXU5T1VsdmdKNmtnVE5BTFRmZ25yNFhjNXFt?=
 =?utf-8?B?YWo0d0J0UmtUZGJ1WTU3WGxCcTY2b2JTWk1pWFFlTVBwUWprSzZJWnZDdTAz?=
 =?utf-8?B?Z2N5L2pHSUdQUDYxRlRNZW9saTRjMDh0QWFVbjFSQjd5cTl2WVFSNVpLd1N1?=
 =?utf-8?B?VnVpRFowRSs1N0dxSHh3eC9DYVlpVEczd0dHdjBtQW5veUNBU21JZTFYblB3?=
 =?utf-8?B?emZ3a1RCMVY0RDVzS3haMjhiSjIrQ0plNk5qVVRsZnpYVm4wdDJuVmxwL2Q3?=
 =?utf-8?B?UzJDRGhJUGIrT1dKV0ZyTHRiZTdwWmRVVjlsYTBGSDF3WFR0RU4yMnZmdWIv?=
 =?utf-8?B?Vkt5MGJtaHFPeTJWSzJUQ0VrcWZDR0xCUm1CblkvYWxndEtabXFDNjhHQkt2?=
 =?utf-8?B?YjlFaCtOVHRJeGE2VDVPYjRCMmxTVjJNeGIrUTNTejhpMDZTVm9sMVBQdm5G?=
 =?utf-8?B?SFU3LzNUNjdyMG1aTHNqWDZjNXVIdUZPai8rOE5ERldYZS9oVlF0TFZia2pw?=
 =?utf-8?B?QUV5Qm1RZFRYeDJnWkt0N0R2YVlpeXMrSi8zeXpYNU1VV0VVRTV0cWNHV09V?=
 =?utf-8?B?a1EwaTZTa0krN2RnVVJUdnoxb3JEOUhSc1pwVUEwdURmcytCa3dBT215Ullz?=
 =?utf-8?B?SmV2aDBBUlpubFZwUlJzYmZFYStRd1ZKbit1Y3hWd3VOaWkxOFM0bUI4c0JG?=
 =?utf-8?B?WGwrU2kvTTBrd0tNY3ZkSmVTVlVveS9DbWRvaUd0cklzazhpY3dNT29reDMz?=
 =?utf-8?B?K0lpeGlGVTYyQkRlUzVYNE00UWFvQkxEckFmVkRxSE5oM2ptNlhxYXdsc2M0?=
 =?utf-8?B?eTZHa0VaSWpHUU01Q2tQY2I4TTN1YmFrbk9GRkszbGVKSWNRQVRGL3NkdXBQ?=
 =?utf-8?B?WDAxWGp1U2kzVTJTS3pwQSttT3Y5RkY0ZFE5VE10QkdQV1pKeUNLN2tYaVNj?=
 =?utf-8?B?a0JWTUwvNEJTUHVncnBtMFVsRzFhUEhsMDViRWt5ZU52MTFSVWYyQUJ1T1hH?=
 =?utf-8?B?aW5XeG4ybHlkalkySmVpQWYzUGRtbEZMUWtpRnhFQWt1Tkt0T21oV3pwZkI4?=
 =?utf-8?B?dkFNVy9FZUQzcDNrZmN5S2JwZXBzTVY5elJQZUhqRllod2k4cXB2dlJZZTFS?=
 =?utf-8?B?cTFqVjBoQUpJNEd1K05MUDNGRnI2NzRrTzdiS0hHWlNSVGQ1bmpjMHlHZ29o?=
 =?utf-8?B?SmlRSEtQZW9qcFd2SWJacUdWYk85K3NiZTZSTmFvc1ZHUHh6U00xalJXYldK?=
 =?utf-8?B?ajlTVVIxZlNzK2VPZlJ5NVRZcmRFaEhxR0F3ODFJdHlWdit5V01DRUQ5K3JE?=
 =?utf-8?B?aytYK3lnYUtBZkpzelFSSlVXVk5CZzd2dzBtVzNwbExSb0FFSXEyZHdibDUy?=
 =?utf-8?B?cUYrQWgwV2c2R1VJY3ZDYW9kRzkxeFQ4bEZ3d3NQZytzcTlvODZZTTE0OVNu?=
 =?utf-8?B?SVhGS05zT3paZjRhZyt3ZUxNUXFSbndJKzliTkkvM2x6bnM2NUg1Y2crU2xk?=
 =?utf-8?B?M2xVQ0k2Wm9JVTJHRzZaeU54N1MrNEN2TXJxR0R3akZpbWp2aHBlNHByaDUx?=
 =?utf-8?B?b1N2aExyc0V4S3BaL3Iwd0hRVjdoSUZ4Mi93eVIyS1liNHpORWFITjNxcUhJ?=
 =?utf-8?B?TXRWdEJWbGQ5OUwxSmtJN200U0x3aFhJcDJydG1MTnlLVkRwdGtsc0JRYWFv?=
 =?utf-8?B?VDFRcmZRS0xOMWhTdTJZaDlSYUNkNXo0VzFqYUJpWXdNUW96YU1NanEzUVF1?=
 =?utf-8?B?QjRUVWxmSEZ2aFVUTnlNYnVCRW9VNWw2R2FqMDFkK0pxeFFTYnN6bzd5Mlhn?=
 =?utf-8?B?bUhEZ3ZGbGlvVGhOaVhSNTdUY3NpRUpVK1g2VXBGdDdOelhnejRRMXlqd3hY?=
 =?utf-8?B?aS9CTElBbUxINi8xcy9PcTlkTU5lWWhmNDlhdTQvVHRIejRENU95TWZRTDZZ?=
 =?utf-8?B?MjdzVGVtL01HcVJCT2ZlZ1RMQzJSRkZLWHU4QVptdFNmT1JlYzVKYVdJRElu?=
 =?utf-8?B?VUJZWkZPTkRDcDcwai9NcFZUSW91cXBzYzdzUCtoSzR5Z3JMOVhpVzkzaG1n?=
 =?utf-8?B?Z0YwVXVrSzR6S0FJV3RrVkF2QjIvbmtGRDN6MTBGZkRLcGlhRGRlbmlwQkM3?=
 =?utf-8?B?QVhjODBKeWdrUnd5K2YzeFZ5VlA0RitnNEVoSVpYMlhJRDJHU0ZWQVlQR2ZW?=
 =?utf-8?B?Y3g1OTBRYmlvdGxXblZEL1AwejN6ZGpQVnc0ZmZXUDU1WXRDUWNkUW8rbXFy?=
 =?utf-8?B?SWVwUmRSU2loMVFXWGFBeWxLRkYrZUZsZm8xMDg0SkpRZmYzSmF5R0FOK1V0?=
 =?utf-8?B?MVhBZ0lQUGZDM0pjNm93WFpZSHExUmVETTgzN2VwOS9GZFlCSFRKUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 900d66a5-100f-4b74-3752-08ded3918a36
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 14:45:17.6747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GSjWr+oRpyn4qnAApilY871b8cHHDOcRY2ylHQBvMvDuuseaSI6593iB5s90XaZ6yJ1MHJZMV/bkAaaWu18inw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB7248
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9406-lists,linux-pwm=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[google.com,collabora.com,linuxfoundation.org,kernel.org,garyguo.net,protonmail.com,umich.edu,onurozkan.dev,gmail.com,arm.com,nvidia.com,ffwll.ch,samsung.com];
	FORGED_RECIPIENTS(0.00)[m:aliceryhl@google.com,m:daniel.almeida@collabora.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:acourbot@nvidia.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E6CE6CE15D

Currently many I/O related structs carry a `SIZE` parameter to denote the
minimum size of the I/O region, while they also carry a field indicating
the actual size. Proliferation of the pattern creates a lot of duplicated
code, and makes it hard to create typed views of I/O.

Introduce a `Region` type that carries the `SIZE` parameter. It is a
wrapper of `[u8]`, which makes it dynamically sized with a metadata of
`usize`. This way, pointers to `Region` naturally carry size information.
This type is required to be 4-byte aligned.

Expose the minimum size information via `MIN_SIZE` constant of the
`KnownSize` trait. Similarly, expose the minimum alignment information via
`KnownSize::MIN_ALIGN`.

With these changes, it is possible to add an associated type to `Io` trait
to represent the type of I/O region. For untyped regions, this is the newly
added `Region` type. Remove `IoKnownSize` as it is no longer necessary. Use
the same mechanism to indicate minimum size of PCI config spaces.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/devres.rs |   6 +--
 rust/kernel/io.rs     | 129 +++++++++++++++++++++++++++++++++-----------------
 rust/kernel/lib.rs    |   3 ++
 rust/kernel/pci.rs    |   1 -
 rust/kernel/pci/io.rs |  40 +++++++---------
 rust/kernel/ptr.rs    |  12 +++++
 6 files changed, 117 insertions(+), 74 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 11ce500e9b76..ed30ccc6e68e 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -68,7 +68,6 @@ struct Inner<T> {
 ///     devres::Devres,
 ///     io::{
 ///         Io,
-///         IoKnownSize,
 ///         Mmio,
 ///         MmioRaw,
 ///         PhysAddr, //
@@ -297,10 +296,7 @@ pub fn device(&self) -> &Device {
     /// use kernel::{
     ///     device::Core,
     ///     devres::Devres,
-    ///     io::{
-    ///         Io,
-    ///         IoKnownSize, //
-    ///     },
+    ///     io::Io,
     ///     pci, //
     /// };
     ///
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index fcc7678fd9e3..d1c5f0121994 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -6,7 +6,11 @@
 
 use crate::{
     bindings,
-    prelude::*, //
+    prelude::*,
+    ptr::{
+        Alignment,
+        KnownSize, //
+    }, //
 };
 
 pub mod mem;
@@ -31,6 +35,57 @@
 /// `CONFIG_PHYS_ADDR_T_64BIT`, and it can be a u64 even on 32-bit architectures.
 pub type ResourceSize = bindings::resource_size_t;
 
+/// Untyped I/O region.
+///
+/// This type can be used when an I/O region without known type information has a compile-time known
+/// minimum size (and a runtime known actual size).
+///
+/// # Invariants
+///
+/// - Size of the region is at least as large as the `SIZE` generic parameter.
+/// - Size of the region is multiple of 4.
+#[repr(C, align(4))]
+pub struct Region<const SIZE: usize = 0> {
+    inner: [u8],
+}
+
+impl<const SIZE: usize> Region<SIZE> {
+    /// Create a raw mutable pointer from given base address and size.
+    ///
+    /// `size` should be at least as large as the minimum size `SIZE`, and `base` and `size` should
+    /// be 4-byte aligned to uphold the type invariant.
+    ///
+    /// Just like other methods on raw pointers, it is not unsafe to create a raw pointer
+    /// that does not uphold the type invariants. However such pointers are not valid.
+    #[inline]
+    pub fn ptr_from_raw_parts_mut(base: *mut u8, size: usize) -> *mut Self {
+        core::ptr::slice_from_raw_parts_mut(base, size) as *mut Region<SIZE>
+    }
+
+    /// Create a raw mutable pointer from given base address and size.
+    ///
+    /// The alignment of `base` is checked, and `size` is checked against the minimum size specified
+    /// via const generics.
+    #[inline]
+    pub fn ptr_try_from_raw_parts_mut(base: *mut u8, size: usize) -> Result<*mut Self> {
+        if size < SIZE || base.align_offset(4) != 0 || !size.is_multiple_of(4) {
+            return Err(EINVAL);
+        }
+
+        Ok(Self::ptr_from_raw_parts_mut(base, size))
+    }
+}
+
+impl<const SIZE: usize> KnownSize for Region<SIZE> {
+    const MIN_SIZE: usize = SIZE;
+    const MIN_ALIGN: Alignment = Alignment::new::<4>();
+
+    #[inline(always)]
+    fn size(p: *const Self) -> usize {
+        (p as *const [u8]).len()
+    }
+}
+
 /// Raw representation of an MMIO region.
 ///
 /// By itself, the existence of an instance of this structure does not provide any guarantees that
@@ -85,7 +140,6 @@ pub fn maxsize(&self) -> usize {
 ///     ffi::c_void,
 ///     io::{
 ///         Io,
-///         IoKnownSize,
 ///         Mmio,
 ///         MmioRaw,
 ///         PhysAddr,
@@ -241,12 +295,25 @@ fn offset(self) -> usize {
 /// For MMIO regions, all widths (u8, u16, u32, and u64 on 64-bit systems) are typically
 /// supported. For PCI configuration space, u8, u16, and u32 are supported but u64 is not.
 pub trait Io {
+    /// Type of this I/O region. For untyped regions, [`Region`] can be used.
+    type Target: ?Sized + KnownSize;
+
     /// Returns the base address of this mapping.
     fn addr(&self) -> usize;
 
     /// Returns the maximum size of this mapping.
     fn maxsize(&self) -> usize;
 
+    /// Returns the absolute I/O address for a given `offset`,
+    /// performing compile-time bound checks.
+    // Always inline to optimize out error path of `build_assert`.
+    #[inline(always)]
+    fn io_addr_assert<U>(&self, offset: usize) -> usize {
+        build_assert!(offset_valid::<U>(offset, Self::Target::MIN_SIZE));
+
+        self.addr() + offset
+    }
+
     /// Returns the absolute I/O address for a given `offset`,
     /// performing runtime bound checks.
     #[inline]
@@ -336,7 +403,7 @@ fn try_write64(&self, value: u64, offset: usize) -> Result
     #[inline(always)]
     fn read8(&self, offset: usize) -> u8
     where
-        Self: IoKnownSize + IoCapable<u8>,
+        Self: IoCapable<u8>,
     {
         self.read(offset)
     }
@@ -345,7 +412,7 @@ fn read8(&self, offset: usize) -> u8
     #[inline(always)]
     fn read16(&self, offset: usize) -> u16
     where
-        Self: IoKnownSize + IoCapable<u16>,
+        Self: IoCapable<u16>,
     {
         self.read(offset)
     }
@@ -354,7 +421,7 @@ fn read16(&self, offset: usize) -> u16
     #[inline(always)]
     fn read32(&self, offset: usize) -> u32
     where
-        Self: IoKnownSize + IoCapable<u32>,
+        Self: IoCapable<u32>,
     {
         self.read(offset)
     }
@@ -363,7 +430,7 @@ fn read32(&self, offset: usize) -> u32
     #[inline(always)]
     fn read64(&self, offset: usize) -> u64
     where
-        Self: IoKnownSize + IoCapable<u64>,
+        Self: IoCapable<u64>,
     {
         self.read(offset)
     }
@@ -372,7 +439,7 @@ fn read64(&self, offset: usize) -> u64
     #[inline(always)]
     fn write8(&self, value: u8, offset: usize)
     where
-        Self: IoKnownSize + IoCapable<u8>,
+        Self: IoCapable<u8>,
     {
         self.write(offset, value)
     }
@@ -381,7 +448,7 @@ fn write8(&self, value: u8, offset: usize)
     #[inline(always)]
     fn write16(&self, value: u16, offset: usize)
     where
-        Self: IoKnownSize + IoCapable<u16>,
+        Self: IoCapable<u16>,
     {
         self.write(offset, value)
     }
@@ -390,7 +457,7 @@ fn write16(&self, value: u16, offset: usize)
     #[inline(always)]
     fn write32(&self, value: u32, offset: usize)
     where
-        Self: IoKnownSize + IoCapable<u32>,
+        Self: IoCapable<u32>,
     {
         self.write(offset, value)
     }
@@ -399,7 +466,7 @@ fn write32(&self, value: u32, offset: usize)
     #[inline(always)]
     fn write64(&self, value: u64, offset: usize)
     where
-        Self: IoKnownSize + IoCapable<u64>,
+        Self: IoCapable<u64>,
     {
         self.write(offset, value)
     }
@@ -582,7 +649,7 @@ fn try_update<T, L, F>(&self, location: L, f: F) -> Result
     fn read<T, L>(&self, location: L) -> T
     where
         L: IoLoc<T>,
-        Self: IoKnownSize + IoCapable<L::IoType>,
+        Self: IoCapable<L::IoType>,
     {
         let address = self.io_addr_assert::<L::IoType>(location.offset());
 
@@ -614,7 +681,7 @@ fn read<T, L>(&self, location: L) -> T
     fn write<T, L>(&self, location: L, value: T)
     where
         L: IoLoc<T>,
-        Self: IoKnownSize + IoCapable<L::IoType>,
+        Self: IoCapable<L::IoType>,
     {
         let address = self.io_addr_assert::<L::IoType>(location.offset());
         let io_value = value.into();
@@ -658,7 +725,7 @@ fn write_reg<T, L, V>(&self, value: V)
     where
         L: IoLoc<T>,
         V: LocatedRegister<Location = L, Value = T>,
-        Self: IoKnownSize + IoCapable<L::IoType>,
+        Self: IoCapable<L::IoType>,
     {
         let (location, value) = value.into_io_op();
 
@@ -690,7 +757,7 @@ fn write_reg<T, L, V>(&self, value: V)
     fn update<T, L, F>(&self, location: L, f: F)
     where
         L: IoLoc<T>,
-        Self: IoKnownSize + IoCapable<L::IoType> + Sized,
+        Self: IoCapable<L::IoType> + Sized,
         F: FnOnce(T) -> T,
     {
         let address = self.io_addr_assert::<L::IoType>(location.offset());
@@ -704,28 +771,6 @@ fn update<T, L, F>(&self, location: L, f: F)
     }
 }
 
-/// Trait for types with a known size at compile time.
-///
-/// This trait is implemented by I/O backends that have a compile-time known size,
-/// enabling the use of infallible I/O accessors with compile-time bounds checking.
-///
-/// Types implementing this trait can use the infallible methods in [`Io`] trait
-/// (e.g., `read8`, `write32`), which require `Self: IoKnownSize` bound.
-pub trait IoKnownSize: Io {
-    /// Minimum usable size of this region.
-    const MIN_SIZE: usize;
-
-    /// Returns the absolute I/O address for a given `offset`,
-    /// performing compile-time bound checks.
-    // Always inline to optimize out error path of `build_assert`.
-    #[inline(always)]
-    fn io_addr_assert<U>(&self, offset: usize) -> usize {
-        build_assert!(offset_valid::<U>(offset, Self::MIN_SIZE));
-
-        self.addr() + offset
-    }
-}
-
 /// Implements [`IoCapable`] on `$mmio` for `$ty` using `$read_fn` and `$write_fn`.
 macro_rules! impl_mmio_io_capable {
     ($mmio:ident, $(#[$attr:meta])* $ty:ty, $read_fn:ident, $write_fn:ident) => {
@@ -758,6 +803,8 @@ unsafe fn io_write(&self, value: $ty, address: usize) {
 );
 
 impl<const SIZE: usize> Io for Mmio<SIZE> {
+    type Target = Region<SIZE>;
+
     /// Returns the base address of this mapping.
     #[inline]
     fn addr(&self) -> usize {
@@ -771,10 +818,6 @@ fn maxsize(&self) -> usize {
     }
 }
 
-impl<const SIZE: usize> IoKnownSize for Mmio<SIZE> {
-    const MIN_SIZE: usize = SIZE;
-}
-
 impl<const SIZE: usize> Mmio<SIZE> {
     /// Converts an `MmioRaw` into an `Mmio` instance, providing the accessors to the MMIO mapping.
     ///
@@ -798,6 +841,8 @@ pub unsafe fn from_raw(raw: &MmioRaw<SIZE>) -> &Self {
 pub struct RelaxedMmio<const SIZE: usize = 0>(Mmio<SIZE>);
 
 impl<const SIZE: usize> Io for RelaxedMmio<SIZE> {
+    type Target = Region<SIZE>;
+
     #[inline]
     fn addr(&self) -> usize {
         self.0.addr()
@@ -809,10 +854,6 @@ fn maxsize(&self) -> usize {
     }
 }
 
-impl<const SIZE: usize> IoKnownSize for RelaxedMmio<SIZE> {
-    const MIN_SIZE: usize = SIZE;
-}
-
 impl<const SIZE: usize> Mmio<SIZE> {
     /// Returns a [`RelaxedMmio`] reference that performs relaxed I/O operations.
     ///
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 9512af7156df..68f4d9a3425d 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -16,6 +16,9 @@
 // Please see https://github.com/Rust-for-Linux/linux/issues/2 for details on
 // the unstable features in use.
 //
+// Stable since Rust 1.87.0.
+#![feature(unsigned_is_multiple_of)]
+//
 // Stable since Rust 1.89.0.
 #![feature(generic_arg_infer)]
 //
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 5071cae6543f..c6d6bd8f251d 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -43,7 +43,6 @@
 pub use self::io::{
     Bar,
     ConfigSpace,
-    ConfigSpaceKind,
     ConfigSpaceSize,
     Extended,
     Normal, //
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 0461e01aaa20..b4996aa059d8 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -10,11 +10,12 @@
     io::{
         Io,
         IoCapable,
-        IoKnownSize,
         Mmio,
-        MmioRaw, //
+        MmioRaw,
+        Region, //
     },
-    prelude::*, //
+    prelude::*,
+    ptr::KnownSize, //
 };
 use core::{
     marker::PhantomData,
@@ -46,28 +47,21 @@ pub const fn into_raw(self) -> usize {
     }
 }
 
-/// Marker type for normal (256-byte) PCI configuration space.
-pub struct Normal;
+/// Alias for normal (256-byte) PCI configuration space.
+pub type Normal = Region<256>;
 
-/// Marker type for extended (4096-byte) PCIe configuration space.
-pub struct Extended;
+/// Alias for extended (4096-byte) PCIe configuration space.
+pub type Extended = Region<4096>;
 
 /// Trait for PCI configuration space size markers.
 ///
 /// This trait is implemented by [`Normal`] and [`Extended`] to provide
 /// compile-time knowledge of the configuration space size.
-pub trait ConfigSpaceKind {
-    /// The size of this configuration space in bytes.
-    const SIZE: usize;
-}
+pub trait ConfigSpaceKind: KnownSize {}
 
-impl ConfigSpaceKind for Normal {
-    const SIZE: usize = 256;
-}
+impl ConfigSpaceKind for Normal {}
 
-impl ConfigSpaceKind for Extended {
-    const SIZE: usize = 4096;
-}
+impl ConfigSpaceKind for Extended {}
 
 /// The PCI configuration space of a device.
 ///
@@ -77,7 +71,7 @@ impl ConfigSpaceKind for Extended {
 /// The generic parameter `S` indicates the maximum size of the configuration space.
 /// Use [`Normal`] for 256-byte legacy configuration space or [`Extended`] for
 /// 4096-byte PCIe extended configuration space (default).
-pub struct ConfigSpace<'a, S: ConfigSpaceKind = Extended> {
+pub struct ConfigSpace<'a, S: ?Sized + ConfigSpaceKind = Extended> {
     pub(crate) pdev: &'a Device<device::Bound>,
     _marker: PhantomData<S>,
 }
@@ -85,7 +79,7 @@ pub struct ConfigSpace<'a, S: ConfigSpaceKind = Extended> {
 /// Implements [`IoCapable`] on [`ConfigSpace`] for `$ty` using `$read_fn` and `$write_fn`.
 macro_rules! impl_config_space_io_capable {
     ($ty:ty, $read_fn:ident, $write_fn:ident) => {
-        impl<'a, S: ConfigSpaceKind> IoCapable<$ty> for ConfigSpace<'a, S> {
+        impl<'a, S: ?Sized + ConfigSpaceKind> IoCapable<$ty> for ConfigSpace<'a, S> {
             unsafe fn io_read(&self, address: usize) -> $ty {
                 let mut val: $ty = 0;
 
@@ -118,7 +112,9 @@ unsafe fn io_write(&self, value: $ty, address: usize) {
 impl_config_space_io_capable!(u16, pci_read_config_word, pci_write_config_word);
 impl_config_space_io_capable!(u32, pci_read_config_dword, pci_write_config_dword);
 
-impl<'a, S: ConfigSpaceKind> Io for ConfigSpace<'a, S> {
+impl<'a, S: ?Sized + ConfigSpaceKind> Io for ConfigSpace<'a, S> {
+    type Target = S;
+
     /// Returns the base address of the I/O region. It is always 0 for configuration space.
     #[inline]
     fn addr(&self) -> usize {
@@ -132,10 +128,6 @@ fn maxsize(&self) -> usize {
     }
 }
 
-impl<'a, S: ConfigSpaceKind> IoKnownSize for ConfigSpace<'a, S> {
-    const MIN_SIZE: usize = S::SIZE;
-}
-
 /// A PCI BAR to perform I/O-Operations on.
 ///
 /// I/O backend assumes that the device is little-endian and will automatically
diff --git a/rust/kernel/ptr.rs b/rust/kernel/ptr.rs
index 3f3e529e9f58..82acb531b17b 100644
--- a/rust/kernel/ptr.rs
+++ b/rust/kernel/ptr.rs
@@ -235,11 +235,20 @@ fn align_up(self, alignment: Alignment) -> Option<Self> {
 ///
 /// This is a generalization of [`size_of`] that works for dynamically sized types.
 pub trait KnownSize {
+    /// Minimum size of this type known at compile-time.
+    const MIN_SIZE: usize;
+
+    /// Minimum alignment of this type known at compile-time.
+    const MIN_ALIGN: Alignment;
+
     /// Get the size of an object of this type in bytes, with the metadata of the given pointer.
     fn size(p: *const Self) -> usize;
 }
 
 impl<T> KnownSize for T {
+    const MIN_SIZE: usize = size_of::<T>();
+    const MIN_ALIGN: Alignment = Alignment::of::<T>();
+
     #[inline(always)]
     fn size(_: *const Self) -> usize {
         size_of::<T>()
@@ -247,6 +256,9 @@ fn size(_: *const Self) -> usize {
 }
 
 impl<T> KnownSize for [T] {
+    const MIN_SIZE: usize = 0;
+    const MIN_ALIGN: Alignment = Alignment::of::<T>();
+
     #[inline(always)]
     fn size(p: *const Self) -> usize {
         p.len() * size_of::<T>()

-- 
2.54.0


