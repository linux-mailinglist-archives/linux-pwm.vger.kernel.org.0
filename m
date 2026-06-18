Return-Path: <linux-pwm+bounces-9320-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rRSGIzMlNGoNPwYAu9opvQ
	(envelope-from <linux-pwm+bounces-9320-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 19:04:51 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BEF6A1BF2
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 19:04:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=OsrKObNZ;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9320-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9320-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AFF8A30117F1
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 17:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03613451AA;
	Thu, 18 Jun 2026 17:04:49 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021095.outbound.protection.outlook.com [52.101.100.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB1A258EDA;
	Thu, 18 Jun 2026 17:04:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781802289; cv=fail; b=P+T9FXkvXBR73SSx43LhSd+GVzti6Z+P7Gr/VqIJswbiIpFOyQ72wTmJoi81UgyAllCNfsueciimBjDc3RTpa+gxlBu0+KMvCilNyY2jhXvFEA6RTZxhxTOmkR+xGRrCqXnTzIxR5DlSUKoYzoVFEc2XuoBw0oqXjvGruF3uzPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781802289; c=relaxed/simple;
	bh=CDWUnJAJ+rH6PqrYdhE9HnqkWK8hkgoOdYipk+Gk8gQ=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=P2R58GgiTP92sVrVE6Xm7BqXVU7dWOSXpMy1UFJWPNjOnuqle6T5GZ63obt2kxOixYsdjqdu+FDymsulv8szcaAv0zmZEXzbw/1iNCMSnyjSyBMnxZ/yMzvE5nclL5QHycTjjUXXkoX8nahkY6UKQt/5yjK7RyDGbIyf5WRMYN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=OsrKObNZ; arc=fail smtp.client-ip=52.101.100.95
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fl1bxgHc72ExxcpJkiDtQ9urQPXiV5AaAbUROj9Dxk0IlIkK7ajksrVModPjm7Rq8KP4sP9kyVM/eqM+NJemSi11aDFjOi4GpsBp2xhsfzruqu53q2DWl8gZhL9vOzl1BxBHGs5j6MHDnysmPoLqwcIZ4n14Iauk8EzhSV7rZIVLRaRIfaNOk8BUzQRNmIe3XYXyq/iUSV9/rSrhlVomzgjlZxRBPZALhvfdxmk2kpaH1dlUvAVjYArKRibuQJmxrhvjGsSpTviy7KGfUplfkag6IoMaD6z3SNwDHurCrfFXtAl+BeqOyo249S/a3gOQV5G/E7cXyjEd1X54nh+JaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfGgWH+/m/wnv/umrTyOPhln6+pFG+Sqa5avNpKldSI=;
 b=Y5efKDaiAYk488sXfacJEPgjuMDKR7eE76s0wQLYu4plxWbvzEhry5SpfkWxK0CKdFQcPKitg1WQrLPylzgaZdDeb0xEREVDinSKCGqtynvLu9/IZ7f2nBqlGHn8lK84OyAZw2m0pe2LnChUyzAY1fsg3B8lSvHAy+UHnJtUjXQXn8x78t7YE/34mNRtaxR/2eT31KGOBPNxzdxkkwx6Nyr1bATdBdF3YnTDnAR/59Hamj0kXmeAJcYg330QBh730DbTsRv+8HjfrqJMAQK1a23uSJgcIMg1eCVfPRSzfhzGdYzKCheAjE17qwDFOgYJR2dxbiIkI3e1zIiJYPe91Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfGgWH+/m/wnv/umrTyOPhln6+pFG+Sqa5avNpKldSI=;
 b=OsrKObNZQyzck3ZLmHZfbruGQNpF/+56UcnQoMbDEi1RGb/rIxskXRr1aMdonRX+QDADgI6sA0xi5qKLHILfO1o1cnzyhUa8PJZhOsfPXDH+aylJyu84UhhJ0U3PLUwmL3O89cNZGm57QISDWbbDHGOXS3t0dZ79of/rtXFBToI=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO4P265MB6966.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:34d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 17:04:43 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 17:04:43 +0000
From: Gary Guo <gary@garyguo.net>
Subject: [PATCH 00/10] rust: driver: use pointers instead of indices for ID
 info
Date: Thu, 18 Jun 2026 18:03:37 +0100
Message-Id: <20260618-id_info-v1-0-96af1e559ef9@garyguo.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOkkNGoC/yXM0QpAQBCF4VfRXFMMLXkVSWvMMi6WdpGSd7e4/
 Oo/5wLPTthDHV3g+BAviw3I4gho0nbkRIZgwBRVqjIM7MSaJcGcSRclEg0VhHp1bOT8npr2t9/
 7mWl753DfDxB+litrAAAA
X-Change-ID: 20260612-id_info-23eca472ccd8
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781802282; l=2475;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=CDWUnJAJ+rH6PqrYdhE9HnqkWK8hkgoOdYipk+Gk8gQ=;
 b=JWv2t7kglzdUdALpK8VAlAf++FtvLSSLPTYQ2od+u83f1jgP7T3MiyT03aV1TPKnS02lstOfq
 FfEHiBEgma7DIGdMO0mC5pIkIOiYin4z4bC0Fr9Ly736bQ0amaKsUdb
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
X-MS-Office365-Filtering-Correlation-Id: 21adea04-fbf3-499c-ecce-08decd5bb162
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|376014|366016|7416014|921020|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	MJf3iRDNLJ9cGXL+5Iqn9jBjblQESWCoPtgvWbbUO1eNEGOs9dSOwU/YKr50MrCxmi6GeAFrUbPVPXdUdgDi9Pqy4PnwT/Gc6odUORR5fODap/dXaxOcC5GPyFZ2sDySp+2Xnnm0iidMaIc2b6m95I/2A9OERftkwxG/vJ73P6JlL7ftbqPh9w5XFtn/mU5Im6PziTT4Ehc1O2RImzefeu9zIT/X3RHeZ0YGhIqaUu0OQhKS6Xw89y9uwo+EEqiWwmzz70thkmb0O/Hzs/Cxkrpdgon1O+r5e4x23DfH2PaSoWaTRZbpRZCfgbsf//0PisbHn0rLbMBmQdsTrDHw3BZGgkMoRhwzJV7czkyBtQdjKG26A1q28//HUSqRVt186Wf0ShNCIktYG/hE0WKbGtmlW9obVGyue2k9k53uLFldZUT5oB5L6Wczup9sGWGHrulkIqGes3qGYtAwQ3sIwxvbQeeTA0LwsGodKQQAyzQLH7kiw+tyKDeWXU5bCJi28WR+rlyTOCpxK2VANBtzktxC+EL4zpLTxxE231ay9KTmksl8roRdti6tk8BSN6Y2qbPdk1szv3NhBBuqgd6EOvywQ/NdQF9f0+qTOEI1syF9ZbSAGEShg4V8oPdbZd7Rg3Hp2WyiByvby1SjjfA+0/fUlv9LafO85iGgPw5mTHx4aCQVIJ9ssChyb3OBY+V3OhHlsw4DrFlfbGFVvv7z/cnCJxy+0RVBJCuTs2Q5o8Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(376014)(366016)(7416014)(921020)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2VOcUhiUGZmQ2FMNTNISUpzakp4RU11RHluc0RyV2dXQ3pXU2tOUHYrVjBa?=
 =?utf-8?B?TmxSWXZackc0Y0M0ZjBZWVZ1RUx0UkwzWmptWEhJb1EwUlE2YXVRbzYySkN0?=
 =?utf-8?B?QktVcnVwcnZVdElzam43QUJoM1BieWkwMHBuTW8wRnQxME5sU0E0dVhkQW1z?=
 =?utf-8?B?SCszU0hPaUxWTXpQaXlBSmROc25ZdmZ4Vm1nWmx3cTV1SzdoT0pBTEVsRjFk?=
 =?utf-8?B?bVUxL3BsUTVXQ29RSVhsaVRvMU1PQ1ZrL0tvOGlrbkorTERVL3hlVEdaZFl5?=
 =?utf-8?B?UTJFYUhKT1dZblNBTVZkZTNJYWxFWlpHQ3RlWUxaNk5QY0Z5MjlTTTJROXJy?=
 =?utf-8?B?ejRpTndBQ0E1bE1lVUJRTWNyMTB6cEtoQjF5VStLOElTbXRjOFk3UCtkYUQ1?=
 =?utf-8?B?MmFITVlrTkYvWnNtSEcyMXcxUHNyNFpPanBNdmJEOUJHZEpXbFBvU0lCS3FG?=
 =?utf-8?B?RTE5UXB2bFdtS21hTHFtcE5IbDZnMmgyTm1CRjlYNTVGNU1XQmo4ZnMvd1JF?=
 =?utf-8?B?RjVFWlFGQWpWcXVnRWdJMGN0WFVPNmRHM2xpRnBkVFpIcWRIemtobWtTMVdV?=
 =?utf-8?B?U3hUd1U1N1pVS2VBM2xqRzVnY3N3YlFGOG5oN05LNXBnV2VXRE5xSWozQmpo?=
 =?utf-8?B?cWxSM0Z5VlkxakVrOExpdSt1aXVsTlR1Z05PR3FaMUpPQWJEMkFXbDZ5OUxy?=
 =?utf-8?B?V2FCNmFrK1ZFeUJOMXMrL3FUNFRIL0d0cW5hRTkrR0xjOEpCUVhVTktmVDRX?=
 =?utf-8?B?L2dLL0FvNzduUXlyRnpsRzc0aG1KSkRpN05RMWl6R2lGOXNIZGFSaUt0b2Rq?=
 =?utf-8?B?WEdFdGVRM3RlYzRmTTJHaHNoL21ZczQwSTUrVVRHdmdTZzVId1RRalBPVVdK?=
 =?utf-8?B?TE9TcnNDZGd5bWg1KzFORSsvRVRabVF3QUNFNFZEV0JHeWFFcTBUMUtoTkhZ?=
 =?utf-8?B?RmVod2RHaDVGZWhiem5PU3NRdUlTL3RhVy9QUGM3cTJZMVpUU3k2VFBZRk9u?=
 =?utf-8?B?K1ZuNWkwZ1dpcVFrc3RSdTBMSkZSNHh0OGEydzRseGVtTHp1b2hMWjg0NW56?=
 =?utf-8?B?T0Z0em5hOExiRFpwQUVhU3NraDZDeE01M2JxTW93T05rcnBoZGZEV0RBdDZK?=
 =?utf-8?B?VHo1YmRGQlczaWdSMTVQZXVWVFpEVU9VU1duMnVyb0hONGZGcHlpUXpjY3g1?=
 =?utf-8?B?MWgzQW0yQTdqc3UzRzBKbzlkS2ZCNlpQYlUrbm1jVllzSEM4SFpaMDNSQUhI?=
 =?utf-8?B?VDA5Q2NhMm5LZWd5a1VQVTZoc2draGtqRFRZOU9YZkZoM2N2NWpxVDRrbWVD?=
 =?utf-8?B?U3dub25KZTZHQ3pVa1p2Y2hnMVlvZEJJVXZta0hmZU1kbDlmaUhxU1hXUVo4?=
 =?utf-8?B?TWgzSzRSQmk2TVlIc1ZDWnN5VDljQlpmdlMxclpSOXczdjc4ZjlJRW04cFdH?=
 =?utf-8?B?SU96eUZVK09XeW5aMS9TTHRlaDNVQWZaRjhiU3FLZmZxQnFQUU5ldWV6ck5C?=
 =?utf-8?B?Q1RCREhqM1duMllPMmV3eUEyK29PdDhtK3JlL0NoMkgyZGt1TEFHblJ2UmJz?=
 =?utf-8?B?MXpnd1FiUml2R3lJeVVhbWE0c2J2ZVJGZVF4WHJHYm5LZjFZaFhrdzdObkwr?=
 =?utf-8?B?NEUycnlqcTdaWStHZ2VvZ2ZuUnRaNW9CeThudEtXUWdjN3owZHF6czhHQmRr?=
 =?utf-8?B?RXNaUkRLaHVHQVluRE96ajE2YXlqQ1FCYTJyUzVnQlV5d0xPRGF4d09TWHVy?=
 =?utf-8?B?ZTFtYWppd1ZYeDZIbm1OSGYwRlh6bXdNKzdOR0pBSllLdDZxSTNTWlZMOUVo?=
 =?utf-8?B?YXNnSlZkc0o5SC9VeFUxVzBZQjhaRjVQd3djckxCY25oa3k4endaUnVxQnhZ?=
 =?utf-8?B?VldXQjFuUFFZVko4blBRY21JN1pYSVFZLzIwQVFKdzJLVEE5ellhQXZqa2Ex?=
 =?utf-8?B?Q1pXZG9wMEVFa0pkT216dm41eXA4TUV4SSt4Y0ROYVd2MWJGdXdmaHl3MnBs?=
 =?utf-8?B?endsU3YxSDRKbjdWYzJkS2JSclphdFFBRjNPWHpUamd6WlpMVE5uVkV2MmlQ?=
 =?utf-8?B?clFyZmlPblQvbmhmQjZobGdFbW80KzQrOHZIZ1o0YnRnMWt0SHdxc0U3R2lk?=
 =?utf-8?B?N21FME1pNHY1RWtmYzVNUFpyNDh5UGVBMCtHOGVRdUJtck83SllxWWgyN0o4?=
 =?utf-8?B?emJZRi94TFZNK3B6ejBSNGR0WXgxTllpQm1RVGlERnlkSEpJRks5Tis3SkxZ?=
 =?utf-8?B?amwvRFd2NmRBR3ptMGl0c0o5Tit1c3VzcWZvRStLc0dhR0NJN2ZQQm1tV2M4?=
 =?utf-8?B?QXkxSmprbHdMQVptUFFzQXNVb0k5TlN4RWtaMHdCeUtqNTNsekRndz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 21adea04-fbf3-499c-ecce-08decd5bb162
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 17:04:43.5945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: agVaPw6lEKGPQH7EV8t7IsbLTWJ+Kip5sn9Mu8iB395w/LUFfgiUsXy/tGWz7ry3YtQ0sR/oa0IsbiPtQVb2Lw==
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
	TAGGED_FROM(0.00)[bounces-9320-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 40BEF6A1BF2

Most C drivers use a pointer (and cast to kernel_ulong_t) for driver_data
fields in device_id. Rust code currently does not do this, but rather use
indices. These indices then needs to be translated to `&IdInfo` separately
and this is by a side table.

This leads to open-coded ACPI/OF handling in driver.rs, which is not
desirable. Convert the code to use pointers (or rather, static references)
instead.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
Gary Guo (10):
      rust: driver: remove `IdTable::id`
      rust: driver: simplify `IdArray::new_without_index`
      rust: pci: use `Option<&IdInfo>` for device ID info
      rust: net/phy: remove expansion from doc
      rust: driver: centralize device ID handling
      rust: driver: remove `$module_table_name` from `module_device_table`
      rust: driver: store pointers in `DeviceId`
      rust: driver: remove open-coded matching logic
      rust: driver: remove duplicate ID table
      RFC: rust: driver: support map-like syntax for ID table

 drivers/cpufreq/rcpufreq_dt.rs        |   1 -
 drivers/gpu/drm/nova/driver.rs        |   1 -
 drivers/gpu/drm/tyr/driver.rs         |   1 -
 drivers/gpu/nova-core/driver.rs       |   3 +-
 drivers/pwm/pwm_th1520.rs             |   1 -
 rust/kernel/acpi.rs                   |  14 +--
 rust/kernel/auxiliary.rs              |  18 +--
 rust/kernel/device_id.rs              | 205 +++++++++++++++++++---------------
 rust/kernel/driver.rs                 | 114 ++-----------------
 rust/kernel/i2c.rs                    |  26 ++---
 rust/kernel/net/phy.rs                |  66 +----------
 rust/kernel/of.rs                     |  14 +--
 rust/kernel/pci.rs                    |  24 ++--
 rust/kernel/platform.rs               |   5 +-
 rust/kernel/usb.rs                    |  18 +--
 samples/rust/rust_debugfs.rs          |   1 -
 samples/rust/rust_dma.rs              |   3 +-
 samples/rust/rust_driver_auxiliary.rs |   4 +-
 samples/rust/rust_driver_i2c.rs       |   3 -
 samples/rust/rust_driver_pci.rs       |  11 +-
 samples/rust/rust_driver_platform.rs  |   2 -
 samples/rust/rust_driver_usb.rs       |   1 -
 samples/rust/rust_i2c_client.rs       |   2 -
 samples/rust/rust_soc.rs              |   2 -
 24 files changed, 166 insertions(+), 374 deletions(-)
---
base-commit: 4fa3f5fabb30bf00d7475d5a33459ea83d639bf9
change-id: 20260612-id_info-23eca472ccd8

Best regards,
--  
Gary Guo <gary@garyguo.net>


