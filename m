Return-Path: <linux-pwm+bounces-9328-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g+sQFwcmNGqQPwYAu9opvQ
	(envelope-from <linux-pwm+bounces-9328-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 19:08:23 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEAE6A1CB6
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 19:08:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=yK0mVq6+;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9328-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9328-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 59BCB3070DE1
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 17:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF1F3E51C8;
	Thu, 18 Jun 2026 17:05:02 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022084.outbound.protection.outlook.com [52.101.101.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26953749E3;
	Thu, 18 Jun 2026 17:04:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781802302; cv=fail; b=jQw3R/KL+XWyH4KcL24IUI6VnsYOmOlsJy4vCvdhbacuxD4Aqr3ZQyHO8t0KW143KPr1qdio2AKucBxapKQei/w6JzFZC5Vn+F7loa51oIjc5cdLZhB8ekUryGMNm6u+a5jyhWdsRf+pnl+WAaxsQGXQ0EqmXHsp/ByRi7yow4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781802302; c=relaxed/simple;
	bh=6VB/qzYRUIOzBLp0x+BUIo3kEz/WKQ66lBiny8qZTE4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Dx5OPABLyrUuE7VQnfjTS59OcCuiheaqJyIqPeEc4+5UA1c7dXQFejKzt+qt+5zXNSq4CyfecDnVpzR0hanITenfVdUlCD8vJ267+4W2lH0pYczYaoLz2KHEThYWrHkSd5/cSbUmtxIFu5A2mrFYLdkSbS8Juf0W6kcAaidBW9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=yK0mVq6+; arc=fail smtp.client-ip=52.101.101.84
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ycvtrpPNqLVOEjj+tJNjFabuLrptJSszjdFMKDwm20fFdCUve6S/tgu8ht6oH1BVB5yT92/AW1sE4ve+naZ3wzYh8lQulwtd5HUyaDU/IYq0un92tEfk2l4UHGDWFC93M86iyMc+nhO9ntLiz2lfHS1A+F9V2TVwyGKKYJpN6HOMx5nAdTeu1aXJq9N92mndetl0FJs7Ks7/cvaoWz/KygjeXDY+agBZ6Rb43BAAZ9AyardZZr+QTaraZTJfmlNFdUUBJNb+Dq6yQzyILXd94J2MCBlHUFLxEaxu5xjM9Ci0qmf6/FzY+4W/ZFYQWngFyAotbeDIOPktXkBxMvT8fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J69RnLWKQb1CmSgbdVXq4rK7jdrdMvC8HYw+unY12nk=;
 b=KrWF5wAGnRzYSoL7MY/HDo4p/tQ/qyuhIuhphILcSPd91a3gIwydcsa2gUfHb1awJ49f1zJ0PfT3rmXzcy2DoTD7NR9//JSuFFqX4bwqpwsP2iKgKCoxCo4NZsdQ4DlixiFTCUivLzqB0r+VVn3RyCezNcLK0LKb1lxVo4zM5D/nfP3O9D5zptzotYjB+QWs6V0lTqK+Vy4xlmHXR7menfzwhsSwewvta2W11jAoG/xChTtiZDxnLfeqQB4Ij+2ujqBILlEkZrRyvqthEw/0YL6aexdYNUjUoktKb5lvWYvSMqKZjjiJFwCEXzmHmzlABMEuWnrxdhDqBl3NOJQEHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J69RnLWKQb1CmSgbdVXq4rK7jdrdMvC8HYw+unY12nk=;
 b=yK0mVq6+5jR1lBqErsIbEsA82ZCXL8n67KXEzHSpfH+VXW1W/h12oBMjmffgOeJ5X42wME2rJnJPw9yCYitW1OD6gu5BPf5T5axYcroiZ2vfpsooDGiSoTLuMNMPht96tQF4JYkMwcnp9eWWw1z1i1tRhzYz9aZsMUJcWul/RdU=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO4P265MB6966.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:34d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 17:04:47 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 17:04:47 +0000
From: Gary Guo <gary@garyguo.net>
Date: Thu, 18 Jun 2026 18:03:44 +0100
Subject: [PATCH 07/10] rust: driver: store pointers in `DeviceId`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-id_info-v1-7-96af1e559ef9@garyguo.net>
References: <20260618-id_info-v1-0-96af1e559ef9@garyguo.net>
In-Reply-To: <20260618-id_info-v1-0-96af1e559ef9@garyguo.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, Dave Ertman <david.m.ertman@intel.com>, 
 Ira Weiny <iweiny@kernel.org>, Leon Romanovsky <leon@kernel.org>, 
 Len Brown <lenb@kernel.org>, Igor Korotin <igor.korotin@linux.dev>, 
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
 Gary Guo <gary@garyguo.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781802282; l=16818;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=6VB/qzYRUIOzBLp0x+BUIo3kEz/WKQ66lBiny8qZTE4=;
 b=gTf889g6AiB5X05b4ft5xvXD5VEu7xCMFrFJBd2OYXxE9NUrlJTHbL1mA3AI8VfSFKXJvMSVG
 86cGSirTdI7BhU2AKlcIf0ZN09/oLQ2wHZiCtpazHsYtvL4M3U/xcuV
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0548.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::11) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO4P265MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: 8855e334-574f-46f9-10f1-08decd5bb3f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|376014|366016|7416014|921020|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Tm1s5C/tUPUYXhwxkdpdeY02x2Y/b62hzqi42vaN9gFv/0DUB9JM/xd+KOozVtWtlPRhxE0/zra74a9q/OJYQZTQrmJOHeeqDg0AGKkc7CLDbXaCYObkp+Ty/oqsAnuX9toWjm9iZfatonlCXot7+hbBhNnJgZbLs9OGQ5YwfRAuYkZod3JzcivcGbiqhnn2WMz9gRcOoP0GK5jt2m8/KFxlFQ5x1WtOn3aGtmPhzH3L2tmMD44BoVUV05OPhlUI3PFuOJ6eP120VSU4mxgRryJqb7I1mzenx+TPt2ad72XgU0BgpDWAKsl1Rt7Wo+zUPiAUCnjmM/Ee1V7annQHS5vBpV0MoY8lHpOD0wMTuP4Lngs6ZSTwE4H6gT9XZFDW5iU+kg2l4gu3W5ZA115O4OUzIgeQBynaJuo+QY+WXCPTcelgA5CnFgqnCJ1EjxoG9YLCQQe05r8yA7gLNxTClgmQUN7YNfLwwrbSBo9V+Ai2S8z8WARFCSDikV1KJL95r3tAWHisUb5MytX/OwBsGL06pNI3a+8Ya1KRaXLswC5gwGQmoY8heLlSbepLEhboxsi/j4c3HeaMda4iW4aIeD5O7LIjEoSI+2bVTG3/UrRkSliCOisNsAKiauG+7IuxytsNkEIuEru+7jFVb3VWt3da8G4s5psHFfOQ1mrObhoVt3G9wGX7y3sRb5aX5zaCpHuTffjTIfatjimMGwh+P6ur9mCsfTOJJ/sHVen4Obs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(376014)(366016)(7416014)(921020)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzRpZ1ZkbVBHQUpYenk0d00yZXVXVCszSDVpR3Y0N0tZUjh1cjRYM3FLcUpE?=
 =?utf-8?B?TklXL3NZcklDZTFKVHdSZ2crak5DQ2l1REhpSlRYMmVtNmtjN2t2bjhIeGxs?=
 =?utf-8?B?QVFOanpIYXlYNWNKZ3VEMEp2QkVaNGpOcVRCeG1sODlVNzhDMU9XUUFiUFpW?=
 =?utf-8?B?WCtpTS8rbytoa201dW5wdnI3SVJ5WXYyZ3ZKc2tvMEpRVlIwd29weEV5bjRD?=
 =?utf-8?B?d3hsa0V0U0xPT08vK3VEd2xqTWJrdk4zbEZKV2tTVWZMQ2YwVWk5d2hGWU5v?=
 =?utf-8?B?T1pEckNtNnBPTGZrK3NMS2lSc1drRFlKNTV0QXRYbXUzK3FlVnozMXV6NEN4?=
 =?utf-8?B?azR5K01GTkpYVUJ2QjhQU3FOWW9IK3Awd0FjM2FhSFMrRVpuUFIyYkcxZ0pF?=
 =?utf-8?B?OW1IcFhtYVU4WWEzUkJYb3BPL3JDaFJXUFl0YUs2LzNVQlg4ZTBpRE1odm1u?=
 =?utf-8?B?b0hKVFVaakhTRFh4di9HcitLZnpxRVB4SXc4U0YrTFRzdzFxU3F1dFA0bUVt?=
 =?utf-8?B?WGk1aXlEVE00b3RRS2FlSjdocGRqejdQc0ZMQ0YvUjBRSjlDOUhSeTZiVWpl?=
 =?utf-8?B?dmJKaGd2bkJkSEpWRytYU2UvRklzaGNFa3E1VklHNkpueWRodVlRS3lSZlhh?=
 =?utf-8?B?aDlYNUdVYmhuUkpOcE5WN0RaRkgrMWNGcTNjOVR5VWE0SHpRMjc1aFlOQ0hU?=
 =?utf-8?B?OG1ndFprVHVkSUtkM09ldjA5TExlclcwTCs3WjRxUG5WTlBSd3VwRlgyZjFx?=
 =?utf-8?B?WHdqMGx0c2NJM29DSWlURGU0cHY1eVg1aXgyOVl6R2JmWlV1SUcwWHlQSkh3?=
 =?utf-8?B?QVkxa2FiT0M0aklLa2s2QkhRQk52SlRueFgrVjZ2MVBHVVpySGtOc1pCakpN?=
 =?utf-8?B?VlkrczA5ZzNhM2VnZ2JpcFliZEVHRkJ1OVZRSTZHb0ZyVGJBSmJtZkcxU3F5?=
 =?utf-8?B?RjlGYTJNcjFKaHBEK05DN1BXdVVVanloaG9RRXFaZGlMTGhVNm9DVTlQN05T?=
 =?utf-8?B?dGNRNlJyWThJUnI2UGsxWFIwTXJnd1NHcUVKVDlHZGdaZEl3cFlmK2M1c2Nv?=
 =?utf-8?B?bUtQWVpwbFdQR2t4ZHl5b24xRlBRbTdwZTBmUTlFdEpPOURWSk00MmFMeXJF?=
 =?utf-8?B?bVpFUGZmZnU1VmVTRWhpM3Z1VHpyb2FOWXltZ1ZtQ05uTHZZNDNlYk5HOFdF?=
 =?utf-8?B?VXRwRDdITnhoa2ViR2lIcXlMa3NDWEh6UFRvREJ6R09WdUE1ZGl0WVlnM0ll?=
 =?utf-8?B?RlhPakpSMEtpNU9IZU8wQ2VZaVI0UjVFSForMFpvUVEzSzhUTXZKcEVoU0VM?=
 =?utf-8?B?RkhJN09CcEpQYmI1MHJKRjBjcnlwMGxMMUIxM2NkaVZyYzUrRGQ2eVFPcmgy?=
 =?utf-8?B?YlVLSlZLdHIwNHZjQVZJeXNSSU4wd1B1N1JqMFMzVzhwY3VVaklTT1Q4elUz?=
 =?utf-8?B?YmxVVWlkcEl5RFdTTEtiWHlqcnczNHpldTRQbi9hVXR4R2Y4NnFBc1JsdWRP?=
 =?utf-8?B?ZFZ5WHNzVTZnT0p5R1lwMCtobjR6MlVsdkpDVzZtSEdKaXE1TzcwMFlJWTVR?=
 =?utf-8?B?cEozQ1dhaE03ZTU5Z05nZFZReEJ3NVBxQ1BlNlNhUTdRajB1ME12ck02ajht?=
 =?utf-8?B?eWswcTVrVkp2Y3k3eU1vdnJKdnljSU5JQXVBSURuOHp2dURXWWhmOWdUZ3o2?=
 =?utf-8?B?K3E1MVlLcGJlMlBwbngxbUVRL2RWQVpzcDJXUFk3Z2RpYW1QMlFTdUVXT0g0?=
 =?utf-8?B?SEJJaHZic0hhOGgrNUJsN1ZPQXdRRnJ5amR2SWVsZk1tYnhXQlVaSEt5OGQz?=
 =?utf-8?B?OEFzRXJUSUpsNkMxRTZSVkZQMDVXeXh1T2ZMc1BSSzY4cWZMUk5pb0VhOWNh?=
 =?utf-8?B?RUFlYlB5eUV1czVnek8wTXB5L2hWeTRGRVNBYVI2dGVIMjNOV1JNU1pBUzlL?=
 =?utf-8?B?YTJ1dTJtYWtNbTNnR2RCdnZtV3RRT2VxSTlqVFFYSDMzQlJmWjhlak9Ca1NC?=
 =?utf-8?B?aEIwZlpzQjV3YTFBS3Zic3dzODh4QzdsNHhBUEQ4ckowdVIzQnJaOHpuQ2F5?=
 =?utf-8?B?MnZEZWZtNk9UVERsd2tTcnppMDlXMnJZK29MbkJIWG1LQnk5aEFhYkpSajBa?=
 =?utf-8?B?UTJqY1NYZlZHYURNRzl6RExyY0t4WmE0cTk3UVp3YkJrak8xNGdZNG5taGVj?=
 =?utf-8?B?YnRaaU5xMllmRW5KR1htVUdOemsxajJGaTV4NFhzSXJac1JhQ0tHY21GbDc1?=
 =?utf-8?B?WlpiM2QxN3Fna0NLS0tka0Z0VU9rQU5tTGt1Vnk4U0FMeEtBUGRnRFdNNDM5?=
 =?utf-8?B?VXZ3WGZSVUZGY1pJblpFMTNNWXZvMm5JQ3RWOUJ3eUpDdU1MN216dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8855e334-574f-46f9-10f1-08decd5bb3f0
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 17:04:47.8485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7NJ7ECR+wdmrbCWf+eEYCG8/h6GQvThkQn8DIpCbzfsv1ej0t9pWXLBFQsnEXytMwRxDlZXq0zj0b3683gO9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6966
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[47];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9328-lists,linux-pwm=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,protonmail.com,google.com,umich.edu,collabora.com,nvidia.com,onurozkan.dev,gmail.com,ffwll.ch,arm.com,intel.com,linux.dev,linaro.org,samsung.com,redhat.com];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:daniel.almeida@collabora.com,m:tamird@kernel.org,m:acourbot@nvidia.com,m:work@onurozkan.dev,m:fujita.tomonori@gmail.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:david.m.ertman@intel.com,m:iweiny@kernel.org,m:leon@kernel.org,m:lenb@kernel.org,m:igor.korotin@linux.dev,m:robh@kernel.org,m:saravanak@kernel.org,m:viresh.kumar@linaro.org,m:m.wilczynski@samsung.com,m:fustini@kernel.org,m:guoren@kernel.org,m:wefu@redhat.com,m:ukleinek@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pci@vger.kernel.org,m:lin
 ux-acpi@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-pm@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:linux-pwm@vger.kernel.org,m:gary@garyguo.net,m:fujitatomonori@gmail.com,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime,0.data:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3CEAE6A1CB6

The common practice in C drivers is to store pointers into `driver_data`
field of device IDs. The Rust code is however currently storing indices
into the fields and then carry a side table that maps the index to
pointers.

It is much simpler to just have `DeviceId` carry the pointer like C code
does. However, just doing so naively would cause a "pointers cannot be cast
to integers during const eval" error, as kernel_ulong_t does not have
provenance while pointers do, and Rust forbids `expose_provenance` during
consteval.

Work around this limitation by wrapping raw IDs in `MaybeUninit`.
`MaybeUninit` is allowed to host arbitrary bytes with or without
provenance, so we can just then use `unsafe` to store a pointer with
provenance there. This has the same effect as changing the C-side
definition to use `void*` instead of `kernel_ulong_t`, but without actually
changing the C side.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/acpi.rs      |  4 ---
 rust/kernel/auxiliary.rs |  8 ++---
 rust/kernel/device_id.rs | 88 +++++++++++++++++++++++++++++-------------------
 rust/kernel/driver.rs    | 14 ++++----
 rust/kernel/i2c.rs       |  7 ++--
 rust/kernel/of.rs        |  4 ---
 rust/kernel/pci.rs       | 11 +++---
 rust/kernel/usb.rs       |  7 ++--
 8 files changed, 73 insertions(+), 70 deletions(-)

diff --git a/rust/kernel/acpi.rs b/rust/kernel/acpi.rs
index 315f2f2af446..ea2ce61ee393 100644
--- a/rust/kernel/acpi.rs
+++ b/rust/kernel/acpi.rs
@@ -25,10 +25,6 @@ unsafe impl RawDeviceId for DeviceId {
 // SAFETY: `DRIVER_DATA_OFFSET` is the offset to the `driver_data` field.
 unsafe impl RawDeviceIdIndex for DeviceId {
     const DRIVER_DATA_OFFSET: usize = core::mem::offset_of!(bindings::acpi_device_id, driver_data);
-
-    fn index(&self) -> usize {
-        self.0.driver_data
-    }
 }
 
 impl DeviceId {
diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 59787c9bff26..aa13d8866a19 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -93,7 +93,9 @@ extern "C" fn probe_callback(
         // SAFETY: `DeviceId` is a `#[repr(transparent)`] wrapper of `struct auxiliary_device_id`
         // and does not add additional invariants, so it's safe to transmute.
         let id = unsafe { &*id.cast::<DeviceId>() };
-        let info = T::ID_TABLE.info(id.index());
+
+        // SAFETY: `id` comes from `T::ID_TABLE` which is of type `IdArray<_, T::IdInfo>`.
+        let info = unsafe { id.info_unchecked::<T::IdInfo>() };
 
         from_result(|| {
             let data = T::probe(adev, info);
@@ -169,10 +171,6 @@ unsafe impl RawDeviceId for DeviceId {
 unsafe impl RawDeviceIdIndex for DeviceId {
     const DRIVER_DATA_OFFSET: usize =
         core::mem::offset_of!(bindings::auxiliary_device_id, driver_data);
-
-    fn index(&self) -> usize {
-        self.0.driver_data
-    }
 }
 
 /// IdTable type for auxiliary drivers.
diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
index 84852a2d9ad7..59453588df0e 100644
--- a/rust/kernel/device_id.rs
+++ b/rust/kernel/device_id.rs
@@ -5,7 +5,10 @@
 //! Each bus / subsystem that matches device and driver through a bus / subsystem specific ID is
 //! expected to implement [`RawDeviceId`].
 
-use core::mem::MaybeUninit;
+use core::{
+    marker::PhantomData,
+    mem::MaybeUninit, //
+};
 
 /// Marker trait to indicate a Rust device ID type represents a corresponding C device ID type.
 ///
@@ -47,15 +50,48 @@ pub unsafe trait RawDeviceIdIndex: RawDeviceId {
     /// The offset (in bytes) to the context/data field in the raw device ID.
     const DRIVER_DATA_OFFSET: usize;
 
-    /// The index stored at `DRIVER_DATA_OFFSET` of the implementor of the [`RawDeviceIdIndex`]
-    /// trait.
-    fn index(&self) -> usize;
+    /// Obtain the data pointer stored inside the device ID.
+    ///
+    /// # Safety
+    ///
+    /// `&Self` must be stored inside a `IdArray<Self, U>`.
+    unsafe fn info_unchecked<U>(&self) -> &'static U {
+        // SAFETY: By safety requirement of the trait, this is `self.driver_data as *const U` and by
+        // the safety requirement of the function, this is stored in `IdArray<Self, U>` so is
+        // convertible to `&'static U`.
+        unsafe {
+            core::ptr::from_ref(self)
+                .byte_add(Self::DRIVER_DATA_OFFSET)
+                .cast::<&U>()
+                .read()
+        }
+    }
+
+    /// Obtain the data pointer stored inside the device ID.
+    ///
+    /// # Safety
+    ///
+    /// `&Self` must be stored inside a `IdArray<Self, U>`, or has NULL (or 0) as driver data.
+    unsafe fn info_unchecked_opt<U>(&self) -> Option<&'static U> {
+        // SAFETY: By safety requirement of the trait, this is `self.driver_data as *const U` and by
+        // the safety requirement of the function, if this is stored in `IdArray<Self, U>`, this is
+        // convertible to `Option<&'static U>`. Otherwise it is NULL which is `None` as
+        // `Option<&U>`.
+        unsafe {
+            core::ptr::from_ref(self)
+                .byte_add(Self::DRIVER_DATA_OFFSET)
+                .cast::<Option<&U>>()
+                .read()
+        }
+    }
 }
 
 /// A zero-terminated device id array.
 #[repr(C)]
 pub struct RawIdArray<T: RawDeviceId, const N: usize> {
-    ids: [T::RawType; N],
+    // This is `MaybeUninit<T::RawType>` so any bytes inside it can carry provenance in CTFE.
+    // If this were `T::RawType`, integer fields would not be able to contain pointers.
+    ids: [MaybeUninit<T::RawType>; N],
     sentinel: MaybeUninit<T::RawType>,
 }
 
@@ -68,18 +104,17 @@ pub const fn size(&self) -> usize {
 
 /// A zero-terminated device id array, followed by context data.
 #[repr(C)]
-pub struct IdArray<T: RawDeviceId, U, const N: usize> {
+pub struct IdArray<T: RawDeviceId, U: 'static, const N: usize> {
     raw_ids: RawIdArray<T, N>,
-    id_infos: [U; N],
+    phantom: PhantomData<&'static U>,
 }
 
-impl<T: RawDeviceId + RawDeviceIdIndex, U, const N: usize> IdArray<T, U, N> {
+impl<T: RawDeviceId + RawDeviceIdIndex, U: 'static, const N: usize> IdArray<T, U, N> {
     /// Creates a new instance of the array.
     ///
     /// The contents are derived from the given identifiers and context information.
-    pub const fn new(ids: [(T, U); N]) -> Self {
+    pub const fn new(ids: [(T, &'static U); N]) -> Self {
         let mut raw_ids = [const { MaybeUninit::<T::RawType>::uninit() }; N];
-        let mut infos = [const { MaybeUninit::uninit() }; N];
 
         let mut i = 0usize;
         while i < N {
@@ -87,18 +122,15 @@ impl<T: RawDeviceId + RawDeviceIdIndex, U, const N: usize> IdArray<T, U, N> {
             // layout-wise compatible with `RawType`.
             raw_ids[i] = unsafe { core::mem::transmute_copy(&ids[i].0) };
             // SAFETY: by the safety requirement of `RawDeviceIdIndex`, this would be effectively
-            // `raw_ids[i].driver_data = i;`.
+            // `raw_ids[i].driver_data = ids[i].1;`.
             unsafe {
                 raw_ids[i]
                     .as_mut_ptr()
                     .byte_add(T::DRIVER_DATA_OFFSET)
-                    .cast::<usize>()
-                    .write(i);
+                    .cast::<&U>()
+                    .write(ids[i].1);
             }
 
-            // SAFETY: this is effectively a move: `infos[i] = ids[i].1`. We make a copy here but
-            // later forget `ids`.
-            infos[i] = MaybeUninit::new(unsafe { core::ptr::read(&ids[i].1) });
             i += 1;
         }
 
@@ -106,20 +138,15 @@ impl<T: RawDeviceId + RawDeviceIdIndex, U, const N: usize> IdArray<T, U, N> {
 
         Self {
             raw_ids: RawIdArray {
-                // SAFETY: this is effectively `array_assume_init`, which is unstable, so we use
-                // `transmute_copy` instead. We have initialized all elements of `raw_ids` so this
-                // `array_assume_init` is safe.
-                ids: unsafe { core::mem::transmute_copy(&raw_ids) },
+                ids: raw_ids,
                 sentinel: MaybeUninit::zeroed(),
             },
-            // SAFETY: We have initialized all elements of `infos` so this `array_assume_init` is
-            // safe.
-            id_infos: unsafe { core::mem::transmute_copy(&infos) },
+            phantom: PhantomData,
         }
     }
 }
 
-impl<T: RawDeviceId, U, const N: usize> IdArray<T, U, N> {
+impl<T: RawDeviceId, U: 'static, const N: usize> IdArray<T, U, N> {
     /// Reference to the contained [`RawIdArray`].
     pub const fn raw_ids(&self) -> &RawIdArray<T, N> {
         &self.raw_ids
@@ -133,7 +160,7 @@ impl<T: RawDeviceId, const N: usize> IdArray<T, (), N> {
     /// If the device implements [`RawDeviceIdIndex`], consider using [`IdArray::new`] instead.
     pub const fn new_without_index(ids: [T; N]) -> Self {
         // SAFETY: `T` is layout-wise compatible with `T::RawType`, so is the array of them.
-        let raw_ids: [T::RawType; N] = unsafe { core::mem::transmute_copy(&ids) };
+        let raw_ids: [MaybeUninit<T::RawType>; N] = unsafe { core::mem::transmute_copy(&ids) };
         core::mem::forget(ids);
 
         Self {
@@ -141,7 +168,7 @@ impl<T: RawDeviceId, const N: usize> IdArray<T, (), N> {
                 ids: raw_ids,
                 sentinel: MaybeUninit::zeroed(),
             },
-            id_infos: [(); N],
+            phantom: PhantomData,
         }
     }
 }
@@ -155,9 +182,6 @@ impl<T: RawDeviceId, const N: usize> IdArray<T, (), N> {
 pub trait IdTable<T: RawDeviceId, U> {
     /// Obtain the pointer to the ID table.
     fn as_ptr(&self) -> *const T::RawType;
-
-    /// Obtain the pointer to the driver-specific information from an index.
-    fn info(&self, index: usize) -> &U;
 }
 
 impl<T: RawDeviceId, U, const N: usize> IdTable<T, U> for IdArray<T, U, N> {
@@ -166,10 +190,6 @@ fn as_ptr(&self) -> *const T::RawType {
         // to access the sentinel.
         core::ptr::from_ref(self).cast()
     }
-
-    fn info(&self, index: usize) -> &U {
-        &self.id_infos[index]
-    }
 }
 
 /// Create device table alias for modpost.
@@ -184,7 +204,7 @@ macro_rules! module_device_table {
             $device_id_ty,
             $id_info_type,
             { <[$device_id_ty]>::len(&[$($id,)*]) },
-        > = $crate::device_id::IdArray::new([$(($id, $info),)*]);
+        > = $crate::device_id::IdArray::new([$(($id, &$info),)*]);
 
         $crate::module_device_table!($table_type, $table_name);
     };
diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index bf5ba0d27553..824899d76fed 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -107,6 +107,7 @@
 use crate::{
     acpi,
     device,
+    device_id::RawDeviceIdIndex,
     of,
     prelude::*,
     types::Opaque,
@@ -350,7 +351,8 @@ fn acpi_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
                 // and does not add additional invariants, so it's safe to transmute.
                 let id = unsafe { &*raw_id.cast::<acpi::DeviceId>() };
 
-                Some(table.info(<acpi::DeviceId as crate::device_id::RawDeviceIdIndex>::index(id)))
+                // SAFETY: `id` comes from `table` which is of type `IdArray<_, Self::IdInfo>`.
+                Some(unsafe { id.info_unchecked::<Self::IdInfo>() })
             }
         }
     }
@@ -381,9 +383,8 @@ fn of_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
                 // and does not add additional invariants, so it's safe to transmute.
                 let id = unsafe { &*raw_id.cast::<of::DeviceId>() };
 
-                return Some(table.info(
-                    <of::DeviceId as crate::device_id::RawDeviceIdIndex>::index(id),
-                ));
+                // SAFETY: `id` comes from `table` which is of type `IdArray<_, Self::IdInfo>`.
+                return Some(unsafe { id.info_unchecked::<Self::IdInfo>() });
             }
         }
 
@@ -412,9 +413,8 @@ fn of_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
                 //   and does not add additional invariants, so it's safe to transmute.
                 let id = unsafe { &*raw_id.cast::<of::DeviceId>() };
 
-                return Some(table.info(
-                    <of::DeviceId as crate::device_id::RawDeviceIdIndex>::index(id),
-                ));
+                // SAFETY: `id` comes from `table` which is of type `IdArray<_, Self::IdInfo>`.
+                return Some(unsafe { id.info_unchecked::<Self::IdInfo>() });
             }
         }
 
diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
index 55c89ba3a82a..9e551c7e8e41 100644
--- a/rust/kernel/i2c.rs
+++ b/rust/kernel/i2c.rs
@@ -65,10 +65,6 @@ unsafe impl RawDeviceId for DeviceId {
 // SAFETY: `DRIVER_DATA_OFFSET` is the offset to the `driver_data` field.
 unsafe impl RawDeviceIdIndex for DeviceId {
     const DRIVER_DATA_OFFSET: usize = core::mem::offset_of!(bindings::i2c_device_id, driver_data);
-
-    fn index(&self) -> usize {
-        self.0.driver_data
-    }
 }
 
 /// IdTable type for I2C
@@ -212,7 +208,8 @@ fn i2c_id_info(dev: &I2cClient) -> Option<&'static <Self as driver::Adapter>::Id
         // does not add additional invariants, so it's safe to transmute.
         let id = unsafe { &*raw_id.cast::<DeviceId>() };
 
-        Some(table.info(<DeviceId as RawDeviceIdIndex>::index(id)))
+        // SAFETY: `id` comes from `table` which is of type `IdArray<_, Self::IdInfo>`.
+        Some(unsafe { id.info_unchecked::<T::IdInfo>() })
     }
 }
 
diff --git a/rust/kernel/of.rs b/rust/kernel/of.rs
index 35aa6d36d309..d0318f62afd7 100644
--- a/rust/kernel/of.rs
+++ b/rust/kernel/of.rs
@@ -25,10 +25,6 @@ unsafe impl RawDeviceId for DeviceId {
 // SAFETY: `DRIVER_DATA_OFFSET` is the offset to the `data` field.
 unsafe impl RawDeviceIdIndex for DeviceId {
     const DRIVER_DATA_OFFSET: usize = core::mem::offset_of!(bindings::of_device_id, data);
-
-    fn index(&self) -> usize {
-        self.0.data as usize
-    }
 }
 
 impl DeviceId {
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index a3dd48f76353..a630c7fc6a85 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -110,10 +110,13 @@ extern "C" fn probe_callback(
         // SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `struct pci_device_id` and
         // does not add additional invariants, so it's safe to transmute.
         let id = unsafe { &*id.cast::<DeviceId>() };
-        let info = T::ID_TABLE.info(id.index());
+
+        // SAFETY: `id` comes from `T::ID_TABLE` which is of type `IdArray<_, T::IdInfo>` or
+        // `pci_device_id_any` which has 0 as driver_data.
+        let info = unsafe { id.info_unchecked_opt::<T::IdInfo>() };
 
         from_result(|| {
-            let data = T::probe(pdev, Some(info));
+            let data = T::probe(pdev, info);
 
             pdev.as_ref().set_drvdata(data)?;
             Ok(0)
@@ -233,10 +236,6 @@ unsafe impl RawDeviceId for DeviceId {
 // SAFETY: `DRIVER_DATA_OFFSET` is the offset to the `driver_data` field.
 unsafe impl RawDeviceIdIndex for DeviceId {
     const DRIVER_DATA_OFFSET: usize = core::mem::offset_of!(bindings::pci_device_id, driver_data);
-
-    fn index(&self) -> usize {
-        self.0.driver_data
-    }
 }
 
 /// `IdTable` type for PCI.
diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
index 500b5e0ba4ea..8aeff5011755 100644
--- a/rust/kernel/usb.rs
+++ b/rust/kernel/usb.rs
@@ -89,7 +89,8 @@ extern "C" fn probe_callback(
             // does not add additional invariants, so it's safe to transmute.
             let id = unsafe { &*id.cast::<DeviceId>() };
 
-            let info = T::ID_TABLE.info(id.index());
+            // SAFETY: `id` comes from `T::ID_TABLE` which is of type `IdArray<_, T::IdInfo>`.
+            let info = unsafe { id.info_unchecked::<T::IdInfo>() };
             let data = T::probe(intf, id, info);
 
             let dev: &device::Device<device::CoreInternal<'_>> = intf.as_ref();
@@ -242,10 +243,6 @@ unsafe impl RawDeviceId for DeviceId {
 // SAFETY: `DRIVER_DATA_OFFSET` is the offset to the `driver_info` field.
 unsafe impl RawDeviceIdIndex for DeviceId {
     const DRIVER_DATA_OFFSET: usize = core::mem::offset_of!(bindings::usb_device_id, driver_info);
-
-    fn index(&self) -> usize {
-        self.0.driver_info
-    }
 }
 
 /// [`IdTable`](kernel::device_id::IdTable) type for USB.

-- 
2.54.0


