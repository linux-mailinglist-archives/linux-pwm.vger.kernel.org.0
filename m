Return-Path: <linux-pwm+bounces-9589-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9xxHCRS5S2riZAEAu9opvQ
	(envelope-from <linux-pwm+bounces-9589-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 16:17:56 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC79711D91
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 16:17:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=rxYpMJ4b;
	dmarc=pass (policy=none) header.from=garyguo.net;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9589-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9589-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD5E5319BA5B
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jul 2026 12:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690EE42CB1C;
	Mon,  6 Jul 2026 12:44:31 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022076.outbound.protection.outlook.com [52.101.96.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FE842CB1B;
	Mon,  6 Jul 2026 12:44:28 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341871; cv=fail; b=X/akyPMpon8TBd0vASdSAodDiG/T+i+HfiODxEwJoz43tXcPgjXFZw9fYsPvOGiD9scofxtXT9/Ik15c1nCuI0xr9Xl7SFYCNknk4KGV3cOYXPedJRNMvzD9lpTctlMN2kOXHpGfYVrls18zCe/gzxc2kK5z8BSQLkBQUeBRFJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341871; c=relaxed/simple;
	bh=t7zoy3hZ68yuRSuFFvXPIwGF0/F09T6v8DJCISY6szs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bobNzz81Kers8Up3XQ3weLe0xmeS3eDgmCn8WkJ4dw9KaHe5yOYZqKfiUffqN3ISi0y5KVoSZ9oMiwIcsaJkdvr+qU8XnKpNzW8ziv/U5qge0FAX3QL0gThYj97iGF5arO/DukZF9BwWOlfR+NqxnKvT1gwazqZfGFBSgfBnVXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=rxYpMJ4b; arc=fail smtp.client-ip=52.101.96.76
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=owHYGEaaUMD/NlHFsXogQ4lkKlZDvqH+eO5Z+FuBRMNfspSfHYaQUjI8MOps874SrNxRCDRE9kKUtjpvP45xAiMcmgWD2fqNLpS3/tQeZa1A9pDYhSZLMIU6uXn+lWgrlPT8jg7Zz55fZ/F70CYf/AP3YTXQpYyPt1qiQDXxw1c+APjYK/o13L3efxTy9jW+xJNfzS/nREUFKKHOvPqWuypGxpT95mDcUxSFD5rhy6IuuvIwq7lskKDBwEdf5iiYHYh6jieH4eSGZYAXnIgFw8VX2AlaCKpa1lLmFS4bk4d0QimMFL7ZrNF3pgssfPT1qloIbC8aPPuDSu9kxJWbLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AM5ghrbvUFtrkGQBYfVnxLQSMiahYs72IOnCkD5eqM=;
 b=yd0Gin83Rfx+8LZwIWXXC0dn2weF9j59VJSzuAmluEKsAFZiH7/kNVNV9A5AhuTB/A3mGTU9KaepmN/elMZG8O9Uz6fqqbcvBEczgKzHUDgxnpPxPzfNHCEEx3u6Z8grdrST++/u5JuuPdUlz6ahKtNTx4eS1ej+xKYDHpTVoeN15xKWtQ2W7rGH6IUUUG2x9WE7h6y6SvlLaLEqHzfxI8Q4ddbKA9sIRKhkRHGMQMPNixJIVhwRWZE7Zx2WvMaWwk+CbKcoUIq0B6Y5jQrrgg93sh69dGDaiwGoOcE3MCawJJndz4saDSZY3ivE9M3tDX7b78rzk7pzBDdnEg/dxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AM5ghrbvUFtrkGQBYfVnxLQSMiahYs72IOnCkD5eqM=;
 b=rxYpMJ4b3FhNwGg//Jzp1x8c7pPERErw2Sfj0ykAsvlEeR652JM5Q0jSoo6iBJe0AF3HkK4IVQ5KApud/xiaGzJKvuTr0crvgqMxRLreLrTFR07djtu92dmKBto5GFxVViSBc+AjMRqSfcnKdRVxMNQRFvM0l6bKoDPpDlVHL+8=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO7P265MB7617.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:40c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 12:44:25 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 12:44:25 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 06 Jul 2026 13:44:15 +0100
Subject: [PATCH v6 02/20] rust: io: add missing safety requirement in
 `IoCapable` methods
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-io_projection-v6-2-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
In-Reply-To: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783341863; l=3788;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=t7zoy3hZ68yuRSuFFvXPIwGF0/F09T6v8DJCISY6szs=;
 b=bimptA7qdiqVgbgC5oS3YyybhDn5Mx9Hd1XAccyjyLLnMmlhSjtQCZHuC1kclNChSZ6ziXlWP
 Nz3UGATVeXxAis/0NkE+EzVsiys1/kBUlnBHShGTlDbxQy3gSIdrVpc
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P265CA0177.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::20) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO7P265MB7617:EE_
X-MS-Office365-Filtering-Correlation-Id: b55613f9-38b7-4e91-5c09-08dedb5c4fb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|10070799003|18002099003|921020|5023799004|6133799003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	yeRHeJ2kmqu1HamTRlUFA8p+RPnB8hwRGt/izDsE5HmOFPyY46Ci9s6SunDgHbiyAwL7WIhZiZji0coRjmI3lUbsXR/DHVsipvDKq7zYVkwv1iuV1yIrGvHftx/UPNQcRjZDem2S07lQuQauTkrjSTHr6rh4cn74U4WgoNcR3RI5+RB/7jDH1XHb/sz7VnqnguqcS/LKGZMMM22vgg69l2b1aUHTJikaSlBifF+LldvGQymirPdHHVHTeGQMHy7047dEa0cLE323uXjbmmnvGoFLSZhHqnBCSext38epxNGL1/MD0U8ie24SlPFBGhEIDb13nLOaRd+Tp55wFPoEwRjX9nA+d0R8jH5QCLbdXuJ9GwhF7zc4XdoMPO+OKT3SIadsRmvJeVoTS6M/tyT6p2UPk1FBd5C//a9ZHU7S4+AtXrzrlKEyjmv3OtVYtQuTAyW2zynHHYt5FSNHESFLpXtKGd12HCJB24ppvOLigXQ85ZM8CC3hW8EpqHIowVJKXG63zBEfaXfdTdreifac2orX+FSRTrQgcwzIgzzEPjAHoX+7gn2P4bcZ+hydAvAGelUBS+z1qD/EZGXCWDWccG0WUlGoik5g+yLejZdrFPCSOAf6jSv7Wu4dAa7Peie95ZuHepjcIXrtT5w/adEjXXmBwPXWSR/9Pw38oNA36jHG+Fwru9iP0JzAxOQVhXnlnFtYrwPdsNW4QTdz7qLIqQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10070799003)(18002099003)(921020)(5023799004)(6133799003)(56012099006)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlBqTkVFcHBPbHZrU2M3cnh5RHlpY2xkL2hNNzRjU3lrOFZ2VDJ6bFpCU2pp?=
 =?utf-8?B?TFpWektlVzZ3UUdOeWZ0bTlDWWZPL1RyU2JGaEZLbE1qRTRLeXZWVE50NXVE?=
 =?utf-8?B?L1Erblpia1BYRWE4VzBoa0VnSTQ1K2xYaDhaL0NQcjQ4eUdSaUx0bzNERFM2?=
 =?utf-8?B?UDNLZ0dRWWk2Z1pxa3VpeVpVSXZuR0dVdVVQa3ZkbjZQZ1ZQQU1OSTZWU0to?=
 =?utf-8?B?RkdpQ05MTEJYMW8xRDZjb2ZuUmZBZFVoVXdyNmZlRkw3TWQvWjFldTFocTJu?=
 =?utf-8?B?Qk1sUUpHbUpkTzRPeVQ2SjlidjFYUW5BcVluOTNMUnMwS2NLZHJhMHUxOW9m?=
 =?utf-8?B?ZU1TR0ZRUXF4anU3eFdQSHo5UzZBQkhNQ3diTTZ2Q3dOZG80RTRpY0dDMW9V?=
 =?utf-8?B?Zk4vWThYK1RKSTZjQ3ZHS1Q4dW1HL0xpeWptSUVZR1ZrNW96ZEpGZm13R090?=
 =?utf-8?B?SWF2NVdSdXV1dFllb3krVUxaVXZHTHFiNGd4ZnpJVjExOHkwQUxPTDhPNFIy?=
 =?utf-8?B?VXBSZnVqMHhSOG5ZUjA0RnQ3UmJsaDdoclBZZzU4SG1Va2F6clVtaWp1ZVBo?=
 =?utf-8?B?UDY4TVR1V3crcHB0NUR5dGdDUUJHODU5UkU5cThLcklldFV6N2JqaWtOMU11?=
 =?utf-8?B?QlQrS2hoaVFvTVlYcU4rODYvd0xCc3dOaVJNMzJRVTdmcTZKZmwwVlRRcS9U?=
 =?utf-8?B?ZUg3R1ZGNERHbWxGR0I4bGUwRDVCRDRxeVpWZlJIaHNZYytGSWFzVnNZOVNy?=
 =?utf-8?B?TjFzWGFFc2t5TDN5RWMzMDlKcmIwK0ZRY0huYkNDZE1EMkw5SHB4YWE5aEcy?=
 =?utf-8?B?c1lFQUZTRE81bWRNYUxOR1BKblhmWjJnQml6SWpYME0xclJmamRLVlZPemFL?=
 =?utf-8?B?QW8vOUJwMWh3eTdua1A1WENBYUhleTVwUVFvRVlKNmtiQTU3TEd1Sk83dms4?=
 =?utf-8?B?dEpVVVRCbEorWGxGSUdnSmlvcmh0Nm41U01JaGRmU2pDWjNSNWtsQUpoQURJ?=
 =?utf-8?B?cUM3ZXR3UHdsZExmQnZBOEhnQmwyS2lEemF6STNjdjRUejVnVXFoNmNLcU4v?=
 =?utf-8?B?SU5lL1FXS3B3NFRZNjdTYVJGRVVmOFRoL3oyNVFiRVZUZEpoQmxlNUNXUU9V?=
 =?utf-8?B?V2pXbjJNVVIzaEo3WitvNVVUaStBbnZUaVVxby9VQXhENG43aXhmZXpoRlVE?=
 =?utf-8?B?cDVKV3FFeitVMWxjS3BORnpNSFduU1hJZXVtV0QzQVVlNldGQWFHYTZOTEhM?=
 =?utf-8?B?VHM0d2NwaVVXMWZvYThoYUNFclNqckZ3VDVOcHZla0p3N3ExWHFQMHVZZTFZ?=
 =?utf-8?B?NGs4akdQWTJYeEhua2JFL1dqY0Z0K09QWlBqVnN1Mkc5WGlNOXFZV2JERnoy?=
 =?utf-8?B?NHFZNUh6WXR0M2hzMjVJZTVSNnlGUW10MzA5QmFsbTQvcVpaRGZWR0FmOU5S?=
 =?utf-8?B?UDlVYzA5ajZQb3BWbFVXc0F3VDBOWlBZYmUyd2x6Q3lGcG9SL2N4UUZUMDhp?=
 =?utf-8?B?SlRnZVJla3ZnNU0yQzNabzl3RG8xN2JzblBLY3NVcXgvc2dCL0Ryam5xVHND?=
 =?utf-8?B?RGh0TGlubVhHS05tSEIzeVJaeG5NZVpTb3J3L2Q1alJsbHFNd0FIN3JBZHRE?=
 =?utf-8?B?YWdNS2ZUK3NYRlYyRUszd096MFNUelBNOFZQOUp5ZEsrbW9JeTVaV25TTWxP?=
 =?utf-8?B?VVZQMEFFYnNVWEFnYVFXWnJhWUpxaEM4dEdvaWliZVFRUXdqdk5LTFpWZnJE?=
 =?utf-8?B?N2lZMmVxUTljRkFMWU9PRjdPdWlvZEFScmd0Rjkzdk5BQXZTQklyUEhoVU1h?=
 =?utf-8?B?NlJHSmdYcUNKRmpwMUNtazFSMkxKSG1EREFVVWI2TkFYLzFNYTI5WjRRcmRS?=
 =?utf-8?B?WUtaOVFJV2RRY1FwanJ1ZDRZMCt4R085NDlkeC9lSmFHcGpnMW5EVElqT2du?=
 =?utf-8?B?V1Q2c0tOZ2tqWW54cmhtNTYrTmFPaWdKNU5ScHVDWEhDdTVnRmFQcWpneXJa?=
 =?utf-8?B?RWd4Vkdpb24zM2RId053R0lJUVY1TCszeDFudDcyQk9DUmk1YWtkOFc0dGRO?=
 =?utf-8?B?OWVwSmFHeGkrNWU0QzhkSnlrZjEra1YzNm55UXM4M29jMVFULzVRVVI3d2VL?=
 =?utf-8?B?MTlPc29scEd2QytKYXIzd1Nva2R3dnJaYjRoeEdNZ2ptRlAwZko5Ym84bTJG?=
 =?utf-8?B?cDM0cTJzb0RFYkp1SDNjMkdyRUI3MS8wOW5iUHpYYlI4S0w0RndMSDhGd2du?=
 =?utf-8?B?SkhubTZucHUza09zOVhKUERLV1hlQkdEeGJROXFnWkJyZkFpOURVVnZwNjN2?=
 =?utf-8?B?UlRWanY1QWl3Rm5mWW1KNFFBWi9Xb3U0dHVoaGVobWczUnVYb0RZQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b55613f9-38b7-4e91-5c09-08dedb5c4fb3
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 12:44:25.4850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mNLJfxSTkjxzR5wkUnnc4Ev29Qa6iHAJFhEtFj7/0SnG6nsFwTP2nfK7BuKPOjrr2ZpJGAFM9UGfNJu81fPjCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7617
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9589-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,vger.kernel.org:from_smtp,garyguo.net:from_mime,garyguo.net:email,garyguo.net:mid,garyguo.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8BC79711D91

The current safety comment on `io_read`/`io_write` does not cover the topic
about alignment. Add it so it can be relied on by implementor of
`IoCapable`.

Expand the check performed by `Io` by taking `self.addr()` into
consideration when checking if `offset` is aligned. For the compile-time
`io_addr_assert` check, check using the known minimum alignment of
`Io::Target` and the accessed type.

While at it, fix the alignment check to use `align_of` instead of
`size_of`. The values match for all primitives (including u64, given that
we do not provide u64 accessor on 32-bit platforms), but are not
necessarily true for custom types.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index d1c5f0121994..d821ee48ed31 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -195,13 +195,14 @@ pub fn maxsize(&self) -> usize {
 #[repr(transparent)]
 pub struct Mmio<const SIZE: usize = 0>(MmioRaw<SIZE>);
 
-/// Checks whether an access of type `U` at the given `offset`
+/// Checks whether an access of type `U` at the given `base` and the given `offset`
 /// is valid within this region.
+///
+/// The `base` is used for alignment checking only. This can be set to 0 to skip the check.
 #[inline]
-const fn offset_valid<U>(offset: usize, size: usize) -> bool {
-    let type_size = core::mem::size_of::<U>();
-    if let Some(end) = offset.checked_add(type_size) {
-        end <= size && offset % type_size == 0
+const fn offset_valid<U>(base: usize, offset: usize, size: usize) -> bool {
+    if let Some(end) = offset.checked_add(size_of::<U>()) {
+        end <= size && (base.wrapping_add(offset) % align_of::<U>() == 0)
     } else {
         false
     }
@@ -220,14 +221,16 @@ pub trait IoCapable<T> {
     ///
     /// # Safety
     ///
-    /// The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
+    /// - The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
+    /// - `address` must be aligned.
     unsafe fn io_read(&self, address: usize) -> T;
 
     /// Performs an I/O write of `value` at `address`.
     ///
     /// # Safety
     ///
-    /// The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
+    /// - The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
+    /// - `address` must be aligned.
     unsafe fn io_write(&self, value: T, address: usize);
 }
 
@@ -309,7 +312,11 @@ pub trait Io {
     // Always inline to optimize out error path of `build_assert`.
     #[inline(always)]
     fn io_addr_assert<U>(&self, offset: usize) -> usize {
-        build_assert!(offset_valid::<U>(offset, Self::Target::MIN_SIZE));
+        // We cannot check alignment with `offset_valid` using `self.addr()`. So set 0 for it and
+        // ensure alignment by checking that the alignment of `U` is smaller or equal to the
+        // alignment of `Self::Target`.
+        const_assert!(Alignment::of::<U>().as_usize() <= Self::Target::MIN_ALIGN.as_usize());
+        build_assert!(offset_valid::<U>(0, offset, Self::Target::MIN_SIZE));
 
         self.addr() + offset
     }
@@ -318,7 +325,7 @@ fn io_addr_assert<U>(&self, offset: usize) -> usize {
     /// performing runtime bound checks.
     #[inline]
     fn io_addr<U>(&self, offset: usize) -> Result<usize> {
-        if !offset_valid::<U>(offset, self.maxsize()) {
+        if !offset_valid::<U>(self.addr(), offset, self.maxsize()) {
             return Err(EINVAL);
         }
 

-- 
2.54.0


