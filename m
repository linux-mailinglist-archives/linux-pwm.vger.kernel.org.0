Return-Path: <linux-pwm+bounces-9510-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t9yWLE0lR2rSTgAAu9opvQ
	(envelope-from <linux-pwm+bounces-9510-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 04:58:21 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 132EC6FE07A
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 04:58:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=W5JFoqs9;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9510-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9510-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3ECC93022694
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2026 02:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FA0274B2A;
	Fri,  3 Jul 2026 02:57:56 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012003.outbound.protection.outlook.com [52.101.48.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85D2263C8F;
	Fri,  3 Jul 2026 02:57:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783047476; cv=fail; b=tih0Sd5oEE9RN+wv0OKBePgnfFzkhlFpZQD/M3lQgeKntgIhqYSrJYoVZ8ZbaUGqAi/GQ4nz+7mBCTHaw3N+EBp/BEV06I6qBBe9kKVEb6cVB24+s+pN77fwQVkvXYkwT3JuSqBxh+GjDCJyBpDcEldIdwMdfpbED7o9MntXoPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783047476; c=relaxed/simple;
	bh=NbDFhoxq3iVvN6efzQs0Rq03wGhTQ8ngQVrd5Ctsxz0=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=QCNA3MlQrq6p3Cmz5mqHbl+pSsn6x1lcLAA5thcAilog/u6iI7uyrUMbt/3J6UkNmDdRPQdI2tYcfovTIg3DvWnCdE2mCpcPBPm+2jqS3xTtcSUV7nLyLCFYHZjeEIdZ0c53U4hPIBz+BDMAdB9O8mCkt05/Gu+j5PNu8b7bk/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W5JFoqs9; arc=fail smtp.client-ip=52.101.48.3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kITM3SomFUCK9tnHyiPHdbEw3BqB4LJfk/mzN/QmdTatc7d3DRWdR0ChU5+tJkJqMRYvbYQ8kAl2bioL8bDQjsa+/ZvUWqgAkYIV4XyHpksBe9NUQTEc3XI0d/xR2NDS+TZ6dPTXfzpbW6dmlnl3TttUvsfW+LYEMNrHSoWPUTMcaEOHxbQZ2f/VB8lClsN4aP7A7/0qmitEk9WI7sTj3kQ5DxpgAX19tKzWZxkV0JWSaoU1Epij418VLe+yiYXVTSCW4AEB9C1GXk77BXAUctCcwI/Z3JVSjfYwtuAN5/HjjziF6DR/6sex6ltcMlilnkGero0o93E4v01AphsbzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oESky0l8RPi4Ne/UKoCfPBe37VZy5y3jZrGtKpkyWbs=;
 b=hZWUx+MuncpP0HDpmt7k8avFm6tkaeVfuxhf0c6M4Lad+qs9CyfASnWMC9ruFmn2T5+HIkL6dMUK5M5gUQXTI7emFGHbAz++5Cc5rFvTAXrFKt8rZPtdhMe4T3/rJt2xr5voaGNCX0Vedb5VuNdKeUtM1Oc0PnexKPyeJyMYf3bTke1buM57S7yQhWGoUQed3LYa3Bu3baBaE6IEm2FaP8dzcd9CTuqk6rOHgvdXgB0XVkggWcJjvgYWh+++KEvn3HKLrCcbNX6CXFm4hGr3adxZt7mTEdQbgLFguPhS4P+KPHDF6piG/NRe5ilStabBCmhskRJ9GdOPLiCtAkJSWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oESky0l8RPi4Ne/UKoCfPBe37VZy5y3jZrGtKpkyWbs=;
 b=W5JFoqs98eeKVYe2oyNfpSZZ6KcMkn6D0EW+wrmD3poEqWGA6efe4RCoKAXSiIgRAeeot9X2fVLL51i80RXy6JRLZt1FKhDsTDy5uxnIdL05uGQw4BL/hB0n0udF1TGpZxXzGcPsn994i99y2VbEvRVhq2bzYU77lT/HUW1/KKomYanQw9FnTtpJMp3qR/ehK+o/p43OTXF9O03BGUPoVuj9PcLtH01pU4Iafi3fu0rlAJ328iPBy1mv2D3F/g5rcsNvgVMior6i2WO7muSXpUQWfRgiVR+4cVrRpOAuE8kl1p/fkTKzEWfsWfpK6XC1EBunVPKRLaVntpYCFtrLHg==
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS5PPF4A654669B.namprd12.prod.outlook.com (2603:10b6:f:fc00::64b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 02:57:47 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 02:57:47 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 11:57:44 +0900
Message-Id: <DJOLKP1V1IDU.1GWHOHBG9CS7@nvidia.com>
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
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Content-Transfer-Encoding: quoted-printable
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-2-d0961471ae50@garyguo.net>
In-Reply-To: <20260626-io_projection-v5-2-d0961471ae50@garyguo.net>
X-ClientProxiedBy: TY4PR01CA0117.jpnprd01.prod.outlook.com
 (2603:1096:405:379::18) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS5PPF4A654669B:EE_
X-MS-Office365-Filtering-Correlation-Id: ca0641ae-9e9d-4568-1396-08ded8aedd03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|10070799003|1800799024|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ieHaZspvQu9B1KUcs6NMykNUK7VR3kLGAM3kegTEBZHYRiwvkg6nZuyu29xLAlnG1oz9eSF1+ZokTwwUZ5AlnLmO1C02mk0C8Hd6lwAa2m/LxyzrgJbLXiWnjF0CVPHTL260AFCI/D0/CCP/QJHkSVLHyGpBeUMQr/awrwaQC0gx9bpbiukPKBJpM3yH0CuegSHdDR0UINmyLvw05CnEXHpnm3+J76v854HR01hPpISnsavsG63BwQ1Z894GlAHZmcPylobcg6+p4Fl/Ti05l+xlb9+Hut7ssQA7RKvUT0oPVNXKHOIU8VUHjYcR2xC5hCsISH1lpa3HoiCeLZge4zfA0ThS1NmbZ83UeFuGMojfnqULHWG9IgrYuY1W2Qx61n4fXWdzBBDs/xMs4recLrKNX/gnIVD8msu65jfyIG/cd20PGMvu6jqqaqwn8pgzdqDu0VgjqBC7SJp1Qb1XAHn4ACSKUj9Pad7Ac/YIq81OX8xEwxzStdL5ZMNifjLNifLxdiWYtGde4jiaxpIdRZhJT/OssVREhqsexGYGMTVCFN/3e0DYzCIX9XKQ7I+0FSwhAaRJQNbTs74prP7iyJVTraSK10ck8bkvfuDfCNccWGmo1AG3TgS2ZCMvlk7UBYy3aYJ7Ame+kEMSN1q2L+5eWsiLVF8zhkG5S9HRiw4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(10070799003)(1800799024)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEdibFhaa01wVHgyN2lsRmo1czdkS1BMNE82TmMxRGxqZmRMSXRvVGtKbXpy?=
 =?utf-8?B?cmdQRHZ4NGtsLzRFTEhRTW1XenkzVCtyUjhRYklxTGh6Nzdab3NhNmFvN1VX?=
 =?utf-8?B?K3BSMGJJdHd0STJTak9sTlNXdGZnZHYvM0xETmNnOW9MaGJFQ1k0bFpXQjJl?=
 =?utf-8?B?ZGZtRy9jcDBqQk12V2NmczFNOTNaSXRNa2JHUVh1ZmFkZ3BxdWdFT2d1dmNL?=
 =?utf-8?B?VmhoWDRGVVBtMWgzR0pWQ0tZbU5UVm9sU1hIRUZCR3VwUzhsTWRsVS9LZGVO?=
 =?utf-8?B?elZ2dXFiNG44K0daNllSTE1Xb3crMnhXU0kvSFAraDlQbkJGcnFzRDNidzVL?=
 =?utf-8?B?QXpyVWdIYTVmb0hXRW91TXFsMGJxTGZsdFNhc2RMZXEvZG9maFZDQ1luNDkv?=
 =?utf-8?B?bFBXUWlHOWZLWnNTTHRaK00vbXNkZGlTZGRNTVFuUE1CbXp2YXlTRHM0dEVU?=
 =?utf-8?B?Q2dLSWRqaktJR3NOWS9OZXNqY0FvRU9WaVhYNW9yUGNHYnZ0STZ2anVmbXJr?=
 =?utf-8?B?Tjg4amxZZFlnRVY2dkNxY2tKWHA4R0xZQk1UTU5YbFlNbkQrYVUvUzJQa3JG?=
 =?utf-8?B?MisyaGMweDV0S2dJcS9EMU00MGtYRXUzSjIyNEJkZXVWNnhYNG0zenpvb1R2?=
 =?utf-8?B?clh6Y1l0M3MxMHowYjhqYjgzR1ZZMzZtU3VyM2VxY2syVS9JdEc5Q0pYS1Bu?=
 =?utf-8?B?Wlozb0ZKQVNmY0pSa203eXQvTHE4NGl2TmRrS0d1T2g0Y0dkTnUwRzNLUzNQ?=
 =?utf-8?B?NnBocGNOcjZzaXc2YWV5TzFtZHJzUDVtOHNTN05LVGFQd0V2alF3RTJTZEdo?=
 =?utf-8?B?WnlHUGtKbXZtdnNYdDJhTDdYTlB0aEVuMGVraEJjTWR2S1RSVG1iYWpLZ1Jt?=
 =?utf-8?B?ZXExR1cvVjAyVFI5SDdqRjM2N2wwS2RacmFoTmxqLzk0M05BZ0lDMVR6bXFp?=
 =?utf-8?B?a2tjOThGYnlOMW81T25HcUZvRi9rdmdMckc3QW5QdjlWcUE0QjhtTmxueFlR?=
 =?utf-8?B?S0RLblRKNnlKYmRON085RUQrUWRvRWVHdlBXemZ0ekdNeFdxQlcxdXhud0RJ?=
 =?utf-8?B?RkhWMjRWZUo3aytQYk5HeHI5Y1c0STJ0Nm5oTEc3bkhMNGRlcmJsd3VPYnNE?=
 =?utf-8?B?ZFlaRE1zM3dQSnFnVmExVEJMOUxPY0NrL0dyWVd3TENmWERibWVRamFERHVT?=
 =?utf-8?B?WGdIMTlTeXBsSjhnQ3ZUUHF2MXV0VzJhS0ZlS05IS2tTTVpNNGhXVThXUUVn?=
 =?utf-8?B?STNGaDlCTzllNWpLd1d4L3d4bDluYnRid01RbTcwa2NENXZVQkZuRk9WVkFi?=
 =?utf-8?B?L2N6T2ViM3VCUjJEb0NCaG9jOFdXTHIrNk9aT2lJZzFaL3hlaFJYT09hcTgr?=
 =?utf-8?B?NzNIQmJTNHFFb0cwdHVMS0I4OWQ2djl1K2hPbHAyNGhBMnIzVkpwUms2eEdk?=
 =?utf-8?B?OUhCN2JOZzlqWXVUaG5SVHJzaUxZZ0x0Y09OUVJFZStDNTE1QitkVThFU05o?=
 =?utf-8?B?a0VzQlljS0dLZDMzVUVKejBUcHNRNFFMY0p0bEZwRU4veWJPbm9mVklnL3kz?=
 =?utf-8?B?a3h2b3lYZVQzUzdTeGl6NVdqZnhJdUxOYXRneHFjSEZqZ1VGdmhxVmZPMnFZ?=
 =?utf-8?B?L3lsYVEzUVVFRUFrVzIrRE5PdlU5L1c1eDJZTXFLOWIzaEtNR2JxVmRMZmpW?=
 =?utf-8?B?SGJLNzZLaUhLM3pGZzlyYlZxbGlDWlVJOGJ1RUNlMzEzZ0k3eXluMUt2b2dP?=
 =?utf-8?B?TUs2WFkvNi9GM25qY2FIQkNKRm1ENEplMXYwSDBPMlBqcVQxUnlHWUR6c1Vy?=
 =?utf-8?B?cmd1dzRtY2tiN3crNnBVSGJPdzVxT1hrSWoxTGJKV1dJZlRESHE2aGRuNU9a?=
 =?utf-8?B?SWErS2hTZlorR0JyVEtrbFRZaFpxSmIwQVhJai8vc3B6QmswTXFaS0xMaHhk?=
 =?utf-8?B?ZERUNUFzZFdEeVJ0dTA4ZjYxeHB2UlFKa0FhRDBkM1l5L2hqYmQvbmhDSVF0?=
 =?utf-8?B?Q0dNYTRJbzE0UDRyYmJuRlZVTG1DekxPQ3pmMTNQdDdOUno3b1I5WnZCaWox?=
 =?utf-8?B?c3VwTGkyUzU4bXdPN0FMNHlwTWc1WGlIMEtMVkJxT0F1cmI4YzlVRXl3ZWlZ?=
 =?utf-8?B?M3Q5ZXU4NnovV2lFQjd3TFZkL0hySFVWa1Q0MTJJeW9qa2oxUUVob2pMTjh6?=
 =?utf-8?B?VEs3QzA5WGk2eFhmNVVVMFljQVhZcWJDSllFRXZtaUJMbmdqbHFKbXUxWFd5?=
 =?utf-8?B?U2R5b20rSllwYmlCcWlxcTd6RGRndjFWbk43NnUrRm9LMm9Ic0ZGdm9mQnlU?=
 =?utf-8?B?ZHo0b0d6MCtHdDNsWStsY2V1Kzd2WkRNSUtOM1hIVXllaEJBVmNtZUxDMnhT?=
 =?utf-8?Q?Bfp57Akd9H1G1Zlr4J0LUrgYZlwuSWfMxqWsw650MR3bH?=
X-MS-Exchange-AntiSpam-MessageData-1: HMI3JnLQBoqGgw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca0641ae-9e9d-4568-1396-08ded8aedd03
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 02:57:47.8448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uygvh2zo4xMQGzCmT4G4BLL1Oe0Sou26vs06U0ovzeohodc8NrZ5Ag+lmGGCJAHT01TAfqpJEoW5xbfJ/HdGqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF4A654669B
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9510-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aliceryhl@google.com,m:daniel.almeida@collabora.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:gary@garyguo.net,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[acourbot@nvidia.com,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_CC(0.00)[google.com,collabora.com,linuxfoundation.org,kernel.org,protonmail.com,umich.edu,onurozkan.dev,gmail.com,arm.com,ffwll.ch,samsung.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[acourbot@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 132EC6FE07A

On Fri Jun 26, 2026 at 11:45 PM JST, Gary Guo wrote:
<...>
> @@ -309,7 +312,11 @@ pub trait Io {
>      // Always inline to optimize out error path of `build_assert`.
>      #[inline(always)]
>      fn io_addr_assert<U>(&self, offset: usize) -> usize {
> -        build_assert!(offset_valid::<U>(offset, Self::Target::MIN_SIZE))=
;
> +        // We cannot check alignment with `offset_valid` using `self.add=
r()`. So set 0 for it and
> +        // ensure alignment by checking that the alignment of `U` is sma=
ller or equal to the
> +        // alignment of `Self::Target`.
> +        const_assert!(Alignment::of::<U>().as_usize() <=3D Self::Target:=
:MIN_ALIGN.as_usize());

With `Region::MIN_ALIGN` being `4`, my understanding is that this will
make `read64` and other infallible 64-bit accessors unusable on untyped
I/O regions?

