Return-Path: <linux-pwm+bounces-9323-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /hd4GoslNGpLPwYAu9opvQ
	(envelope-from <linux-pwm+bounces-9323-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 19:06:19 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4BE6A1C67
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 19:06:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b="EWJ6YWZ/";
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9323-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9323-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5AD43093676
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 17:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D3635A3B1;
	Thu, 18 Jun 2026 17:04:56 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022084.outbound.protection.outlook.com [52.101.101.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A1434887B;
	Thu, 18 Jun 2026 17:04:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781802296; cv=fail; b=NVFsI9yrQkJz2jjwyw5BjE0mUL1V8nd3jUfixkxR2mVOWWD4cbrc46N3gszvTIXfJwVKYhRHHA8b01/hDkR/a6GgcvubjYIvq57NQDgxhg0q7UcdUadJgut1IulRO6MeeWxORwEkcfu4slODeTJSJIMfUjyD8pUytPsnRNqFA5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781802296; c=relaxed/simple;
	bh=2dT/k0xdyDAv/VId4TJjbcCnwySmY8Qww6TVUXxc1A8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dbuOREUVK6fG/957RAylb8hiKk1J1HGgeMtyfd2oBVQXPioXudfmurWeDU9v37hhcIEBPCsa8VHLZ4+Pc2Sb3HBXmmF0pRr+JX04G6I5JZQjhQzGirlLWUvYNyXATsCeX3iyG4LKbNoAP7TB2wP2M95v/jQqpblpusudOfUPtPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=EWJ6YWZ/; arc=fail smtp.client-ip=52.101.101.84
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xF9b25oEBj5LfuB7UfoCA+XBHNyOE6qCgQ6iMSJfV/u/hY4ZRo2moGV2pFSO+a4UTcdDxejOapT2yJzQMWBDLL0h49BRIHwcHoZyaNrT8R9vmzjtCPf7MkdJMAf9u+/cCRdT7aBu1cp3Pt35bkrNodqY8IfltVmOLqbJXkLWy1qPExD7P6gsHgNKi6ecyjo+LWlBye+Ife1x5fgZ1qGRxOcKP3pa8jAvFzqxUFA9svgH4ZLeDEayys6FZJc+qGi+Mf9XhWc8UCcECxFB4mJDnsIJ5QDVKYvkdIdSJnS/AS5ZqJvdMtIzotR7F/lTcwEG/Vozyhl2LSq41RBl+XPEMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYhqXbWIhT3rqYCl5LJZ7ER8BbRtoBickjLIbda0PYs=;
 b=sWM4mXXruqX+fzZTOH726fEu3tZ1cLYNyfirtFpXlwpIWSnxYf6mAn29xJbFV1XeFZkmnwCIN54Q7/zs7lNs3a+8iux/Q7iGoWRnopxiVMIfn35vTSNzIOk4TnScXTL9Ka9xFSul9HuMnV7WddqfoF+u/eV2UWJSBJ3mAHwj9pm2SmJIN3bylwpjMtL0D8IwcKw255x/JGc+g+n3sa0B8r4ioZNbwoVwxzz8mPGoxAjDPzriMjLubENHYNvywchdIUUQneYllxCxQQ5HcznO3//5dqzgO8MBxKRLoWMqT5SuY3jo+16sTVaVNucvxTZskX5icBXAxrloCu7DgFxyoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYhqXbWIhT3rqYCl5LJZ7ER8BbRtoBickjLIbda0PYs=;
 b=EWJ6YWZ/UHTD9oyCCdPma5q+jqsD7rfU8fc6dxiZSpMmQ1EPk3TtFIxxV74KcsOcs6NOfA2BiRy3Cl2hVzo6UiKW2sHHV1NThSkgvxY7CFd9PhG+d/rLnmzTKfXuRfYWkNuHO2V3TEnWVOpxJgos1crsKw3mT/FJZHt9hCd6T8A=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO4P265MB6966.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:34d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 17:04:45 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 17:04:45 +0000
From: Gary Guo <gary@garyguo.net>
Date: Thu, 18 Jun 2026 18:03:40 +0100
Subject: [PATCH 03/10] rust: pci: use `Option<&IdInfo>` for device ID info
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-id_info-v1-3-96af1e559ef9@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781802282; l=4445;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=2dT/k0xdyDAv/VId4TJjbcCnwySmY8Qww6TVUXxc1A8=;
 b=hHTiL8NlLJgasFb9iElQRx85k5nd63h/YNpgkyizAVCiqclVgK6DPI3rGBMvUq6TE18XL2RDS
 WXTMo8r8wNmCv2jCanVUMjbD7CpYAImxKnSWpxc6HEh715ChIlEkR6w
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
X-MS-Office365-Filtering-Correlation-Id: b0fdd7cb-aac0-4c61-b240-08decd5bb283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|376014|366016|7416014|3023799007|921020|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kyK1yBTm/gFzGqoPD5Tj1neUlepzm1Ym/7qwIFl+No2RSJhDZpYfOCUV6HzEcvLeSnN5MPzk083/b4cD512Hk9L+lVZROgZS2X3NpV6qlcF5XeOcH0duPF5ZBc5By3+umCE+aVr2O1B3dbyATObjb1ydUOhv9ye1IWXKHspaOOUsXE4Bkpj8BFtXMCjwDz1HbjAd1gy6itrNmFOLc63jnRQ+ETvGTyJDECc+7wc2hieg44jH0vd1Pk4vPw3X2GLpKwOBwJ/U8FSr6t8bHNaJH8mEWZjheUFiTIzA7mROTuF0lJ8YfYLTdl31aovvnrkWE0ISUqT/EpE+I/h4ALC8hQn4o2vQM3o4flUDuPO8uQzPongWQLLWytAdvNnrEBOeDywGxWxy2/0kqG90T9FYFsNXSl06RzELQYSCOe0eUHFBGaIG6qdcRhNp1gWOgJP28NC1Lhti4wDbFXmgGJl2vw8h3tBg0GDlKrWFW9B7/MqUSszaRr45HaRggw36HPh7vjpzOsiISpAeHQFECzt6LUhUJ0t0QdfGmZ0Fi33T07i/RdJOmTjqcEEGlqxznOWvQqwhmanWaCPgFhzzMt1txQ1BbuLDXoJP2EwejG48G3PCg19nH2ucfCYCMJ1jKeB8UFPwbke4TYKavNLVFRpROGrPHJlfmRnpggKmkv+ihi6gyVv6qrDHKu/r/TXSc2IGg9rZ9KgycwAvymGiT4fii9xHksUZ+OwGvh/bXQL9TAU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(376014)(366016)(7416014)(3023799007)(921020)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFp4L3VGTitrMzB2SnpoOVdFbTlPWG1kMVBFSEMxNHVPU1o2WFQ0d2ZnWTd3?=
 =?utf-8?B?RS92RTB6TjdrZFBvelU3ME14NVlWZzhJeWhCclBTQnJXYkNiMWhycU1HdWhY?=
 =?utf-8?B?VDBtd1ZESHlDYWpRNFVLSklGcjd1a0NvWEhsQ0xic1NZUGIwUUxsTHo4MmtD?=
 =?utf-8?B?aU9XSG4vRFdlMWU5b0YwelFBNE1yTTZyTFd3bnpDanc0L25TMS84VWlOVG1x?=
 =?utf-8?B?YjRvNDAyK1plTWpJWDkwT1VDVUhrQjNtb1lYOGRXMXkrUlNKS21kRElWb2dK?=
 =?utf-8?B?RWVTY3J4eWtRS2s4bVhvVU9RZFNLbGZkNFpzcXV0M1F6R0xGYU9xdUlndmZh?=
 =?utf-8?B?REdOQnEwdmtzY0liZldiSXc0UEtUaUFEWW94MTZoS3p1L1VFVlZJMnQzejZV?=
 =?utf-8?B?ZisxNGFZUTZKeTdBQ3Z0THVJRGtDQ0dEUEo5TUJiQlZxSUxDNHZBUU12bDBM?=
 =?utf-8?B?QWZGRzN2NUpLWGs4T2s1ZVBqQnZZUGNXMEFpQm4vSkp1VHhFQ3hjTndDSGZX?=
 =?utf-8?B?UU1KTHFDRE04OUFrTUg4MzNIQnAzamgxR3QzK1Y2KzlKci9sMGtZYk1DS3da?=
 =?utf-8?B?bVkvWEFBdTJlVFBqNFA3YTJQekhUWHlxSkVQdlo1REF4Yk4xTmVtcHJrTDV2?=
 =?utf-8?B?OE1La25KLzlCQzRIWGlyVklyaEF3SUxZSFFZQmtlbWlsZkt0OStoa1k5L2FN?=
 =?utf-8?B?d29sQ1ZmczF6UUNKSVd0T012U2JHSUtsajFxOEFvY2psWnE4NGllOHJhMHg2?=
 =?utf-8?B?YTV6MDJSaEN4NytBMWw1OE9LSVJZUzQ0cUdzV1Bnb1VmQ1pnV0FLWmN5U0Jq?=
 =?utf-8?B?SVVwWExpOFRRc2Y4M3M1REJXSXdSM0dHTG4zMjlMQzNOVWhTT0IwQmpUSEtQ?=
 =?utf-8?B?REF6enpQWHhkWi84WjVKM1hjM3NMNXUyTnJOUHBFdFcvRzBGLzRyMDNJb2Iv?=
 =?utf-8?B?MEY0TnEzeCtKTUJKU1orV0NNeFZiMnd2TEpKbm1OV0hNU3Nmc2NTNW9wcVVS?=
 =?utf-8?B?Zmp4KzhydWlicnFxY0JTSXBQZ1V3T1Noa1VkVGlaa3VoMzdvVlN0NFFHSFpU?=
 =?utf-8?B?L2ltY3lFSFJZMzJrYlc4VWlXOTMvV1ZScjNuL21QMjlBQk9ON0VVZnVnTS8z?=
 =?utf-8?B?Wll5a3ZVNTBwTnc1VWFZYmNkT2Y0elh1NHpXMEFWck5IQmg3eGRPMkRwLzdx?=
 =?utf-8?B?WkJ0SGpUVjBzWHpKbGE4cHpqTVJUWUwwTkl3REZyeFdqRGlWcnpsdzV2ZzB1?=
 =?utf-8?B?UTJyUDlKOUhHS1RQczE2eWZxbEp0dGJlQ2RWRVFwaDNwVG5wRWZ4R203RjRU?=
 =?utf-8?B?bFhZYVcwbnpxZVQ3cWR1L2R4UnVCaWZmY3ROclVDalkxUWE5bHgvVDdjbVVO?=
 =?utf-8?B?cjN5UlBsejJsb3dwSnhtRGFZcjhuWFE3NGhHNTBncEdaK2V4bUE1YnF5V0pG?=
 =?utf-8?B?azFHemFkMS9mbHNHNmtJaXlmRVI1SHVmNVo1OEVieEFyYk1oc3ZvMmpDVlpa?=
 =?utf-8?B?bnZOZGNIU0syM3VJR1NISlhiWXd6Qmo2ZWl0TmFqeWQyWUpKREhWWjhCRjN2?=
 =?utf-8?B?eWw4dUM5ZTFWNGh6WHhkbFpycFllRThqOWJzdzRZcXJmRFplWmM5NUwrQmZH?=
 =?utf-8?B?QkpBaU9USFBVdlYvT0dNbEVSVEkrSW9CNzNxdURUbXFSbmdlaStmN0dyUnRX?=
 =?utf-8?B?ZFdWY202eWkyRm5Pb0xMMUFZbmVjN0plRjZ3ZGJuaWZZWlozSlV3WWJhYlE3?=
 =?utf-8?B?NW1KanJXc2hIRGQvazFGZUxOMnZ5YjlGdFN4ZmgzZXBVOWpoeFNRKzc2cko2?=
 =?utf-8?B?WUlWVnpCckYzOUxwZU9xVmVYb3Zod2xuSlg5TEY4Wmx1dmdzYmdXYXRrajcv?=
 =?utf-8?B?VjZocVJqcGQvSXBQOGpscGJ2OGxuZlB1Rmlwclc2NUQ2ekdGd3ltSHREbW9Q?=
 =?utf-8?B?empROUhQYi92QWNqTGdPcUJmaS9xOUxXM0lZbnZMbk9Gc1M1anlsTHBkb1pE?=
 =?utf-8?B?M2Z0R3pqRGlBTFVQSDZQUXh1dGwwaE9Oc1RRSUR0a0pFdGF0Q1hndHZNcmVT?=
 =?utf-8?B?dUFFQlhJQXVYR0pCdVFINzMvWjRVY0JLYXNWM2JWT2VkSldmMVhQc21WMldk?=
 =?utf-8?B?S0E5TmVOT3d1OCtiOUh5V1lWSXhpTnBHZTg4SVBYZFlSbFowdmlsTkVlcTJQ?=
 =?utf-8?B?dUVkV2Z6Z0FpL1dhUGxMQlc4dEo2R1VVQlRwcXFYT1ZlYUxVREh1RGg5NzB2?=
 =?utf-8?B?dlVMMnlTS0QvTjJNaXBaRkNtMVhnOUNkQitFdDJaS1lyQXpCQmNPOG9mU0ZZ?=
 =?utf-8?B?cGQxdCt5L1ltOHg5SzM1bERGVXVzSlc3NG1RODgzVGdkVU1ldFVXZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b0fdd7cb-aac0-4c61-b240-08decd5bb283
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 17:04:45.4595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 05dKH2DD4QFNWxL2PUPb5Epe7l0vPTCXlD20XDrZlVxuF0ETVkKXxWVR1ujTQztcu1YLAxzCZEVcKTpqKzyLGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6966
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[47];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9323-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1D4BE6A1C67

It is possible that `pci_device_id_any` will be passed to the driver, e.g.
`driver_override` is used on the device. Therefore, the driver must be able
to handle the case where `driver_data` is 0. Thus, update the `probe`
functions to get `Option`.

The current code cannot tell if the info does not exist or is the first
entry; however this will be achievable once the code is updated to use a
`&'static IdInfo` pointer instead of indices.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/gpu/nova-core/driver.rs       | 2 +-
 rust/kernel/pci.rs                    | 6 +++---
 samples/rust/rust_dma.rs              | 2 +-
 samples/rust/rust_driver_auxiliary.rs | 2 +-
 samples/rust/rust_driver_pci.rs       | 3 ++-
 5 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 5738d4ac521b..5a5f0b63e0f3 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -70,7 +70,7 @@ impl pci::Driver for NovaCoreDriver {
 
     fn probe<'bound>(
         pdev: &'bound pci::Device<Core<'_>>,
-        _info: &'bound Self::IdInfo,
+        _info: Option<&'bound Self::IdInfo>,
     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
         pin_init::pin_init_scope(move || {
             dev_dbg!(pdev, "Probe Nova Core GPU driver.\n");
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 5071cae6543f..0e055e4df99e 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -113,7 +113,7 @@ extern "C" fn probe_callback(
         let info = T::ID_TABLE.info(id.index());
 
         from_result(|| {
-            let data = T::probe(pdev, info);
+            let data = T::probe(pdev, Some(info));
 
             pdev.as_ref().set_drvdata(data)?;
             Ok(0)
@@ -284,7 +284,7 @@ macro_rules! pci_device_table {
 ///
 ///     fn probe<'bound>(
 ///         _pdev: &'bound pci::Device<Core<'_>>,
-///         _id_info: &'bound Self::IdInfo,
+///         _id_info: Option<&'bound Self::IdInfo>,
 ///     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
 ///         Err(ENODEV)
 ///     }
@@ -313,7 +313,7 @@ pub trait Driver {
     /// attempt to initialize the device here.
     fn probe<'bound>(
         dev: &'bound Device<device::Core<'_>>,
-        id_info: &'bound Self::IdInfo,
+        id_info: Option<&'bound Self::IdInfo>,
     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;
 
     /// PCI driver unbind.
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index 5046b4628d0e..9beb37275e0d 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -63,7 +63,7 @@ impl pci::Driver for DmaSampleDriver {
 
     fn probe<'bound>(
         pdev: &'bound pci::Device<Core<'_>>,
-        _info: &'bound Self::IdInfo,
+        _info: Option<&'bound Self::IdInfo>,
     ) -> impl PinInit<Self, Error> + 'bound {
         pin_init::pin_init_scope(move || {
             dev_info!(pdev, "Probe DMA test driver.\n");
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index 2c1351040e45..73c63afc046a 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -79,7 +79,7 @@ impl pci::Driver for ParentDriver {
 
     fn probe<'bound>(
         pdev: &'bound pci::Device<Core<'_>>,
-        _info: &'bound Self::IdInfo,
+        _info: Option<&'bound Self::IdInfo>,
     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
         Ok(ParentData {
             // SAFETY: `ParentData` is the driver's private data, which is dropped when the
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 1aa8197d8698..5547dd704a1b 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -144,7 +144,7 @@ impl pci::Driver for SampleDriver {
 
     fn probe<'bound>(
         pdev: &'bound pci::Device<Core<'_>>,
-        info: &'bound Self::IdInfo,
+        info: Option<&'bound Self::IdInfo>,
     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
         let vendor = pdev.vendor_id();
         dev_dbg!(
@@ -153,6 +153,7 @@ fn probe<'bound>(
             vendor,
             pdev.device_id()
         );
+        let info = info.ok_or(ENODEV)?;
 
         pdev.enable_device_mem()?;
         pdev.set_master();

-- 
2.54.0


