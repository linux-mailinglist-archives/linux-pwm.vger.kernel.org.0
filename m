Return-Path: <linux-pwm+bounces-8835-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Au3BFWC/GkcQwAAu9opvQ
	(envelope-from <linux-pwm+bounces-8835-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 07 May 2026 14:15:17 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B28794E80EE
	for <lists+linux-pwm@lfdr.de>; Thu, 07 May 2026 14:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 115E1300678C
	for <lists+linux-pwm@lfdr.de>; Thu,  7 May 2026 12:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34AD3EFD2D;
	Thu,  7 May 2026 12:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="IZHa5p9P"
X-Original-To: linux-pwm@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011020.outbound.protection.outlook.com [40.107.130.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EEF3EF666;
	Thu,  7 May 2026 12:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778156111; cv=fail; b=bGViZ9OSbfZS/rwMXib3RwKx13PF9Yq3bbgWt7NUMqce1ET3soeJJ5FCenro+K42bAQMQ2uEo7qVXxXRDTJVOMS3atKFXadnusna9zRZXZ5wuZ/7ILqOaNaK/RYJYLq/mGmqn1skqvmJrZgPMmZY2XIo55S3zygXFF4iDdL0CQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778156111; c=relaxed/simple;
	bh=Ensyd5Eykp10ujbn/jvUrprwoJxLrAJwDGJqD88IH4s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=ZgT8vss/+FJLZG2bd190b+x9lwM5lkkCMXu6VBqP0i9PObre1SrRLIO2gW02p0ftYnwWO3yqwtjJNeKjxywCjW7/zS/rbuz3nLnRHy9VJtPl3zMbGbLl16A54HIc4KcMacrQhNHNKFwInKmhJ/q2HOxnwOkYKRhI+rVZwKYqoPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=IZHa5p9P; arc=fail smtp.client-ip=40.107.130.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBjoEXy/7C1zMRICaV47h6Q3Yof9SsyOvLSGIVXOfhvrho1N/Pzm2DJd+NQajoiCz25REUmkbSRnUxPZwBxxS6c5GsawjKHFFAu1dnJ2u+ZEz8aJ/nAwIHVhBqcUZEiRkOQe9AZ1V4iJbxpL7HccaL8ivuY284EkXFkbkM1VgIC07gXnKzYpL3zDCB85WCdBkTa+0WrGw5PpmyhKe46S6MEjM3rKks7qx3J1/fpQsP8r/KgTm983eNl4R4HA/X9Tx3gEhQrJIOCo/qAluFfInDY5mWWUoI5k6RJQtDO1jZPZwK0EbAXTVWAG1B+HEoejk4k5i7KyYrP23aefwGaJNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=or9DUWWTDQ4vXa8LIf8MW/Y9uKYVWRibHd0IulGbVvQ=;
 b=xHgFsZ4tLxlfGniRjiG/hicK/qU315CK+1X2KUTdH5XJbcpXOGa4gq7PzXWQf0v0pP5rllHd5FyMDCnNh+ZpAheYhJIfqnC8ZqdwKVehXBjHu5zRLsQXnV8iGc0OCQxaorKPXSplxdBx18dd3lKy1QWyE/S7prxc48i7cAbiAk8pj2bNgT/OHkLH/qznHC79Xsc9iCi/3mBPmejtp1FakG9N+WGQr5No49OId7wH8i0codkL9RGdGIE7XLMwHuavbnNa5eOYqZ0tjKNrWLWqePviYQHx6vRZWG+zrovWq53U+WanncLqUQdLQt+8ZBwKHrkfPCgvx9gqzWo8mlqdeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=or9DUWWTDQ4vXa8LIf8MW/Y9uKYVWRibHd0IulGbVvQ=;
 b=IZHa5p9PrKlc6pgWd8wmFkicTPaViAIGDy+Z2VPIaWDpBThhvzwmi8f0kzaW7hU3LQ3y9QnOuVLqL6MUqkijCiVxB4og7Zv2ussTYSMilR2/dwXqJsezS8kVtLSlqSswNNeRsKzswgezgH8FoBot1ewQuI7Ag+RX/w96ks9lDf9jYoAQFrF9qZwRt2x4Ms1sm2TLdSmp2J/71rbJw3gb16mhITAK/DFMVIiOy7OmECsCzWVA0Lhr4jD7kjAvoj7165J2u26aBFrD6df8LSb6GQo9+mxvbalSXTEX9jmWRcoHGy2B9Jnp7zVuC/A/jAF8Wcr9IO2dCdZvs9E8SGnioQ==
Received: from CW1P123CA0022.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:292::13)
 by PA1PR10MB8919.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:442::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 12:14:54 +0000
Received: from AMS0EPF000001A3.eurprd05.prod.outlook.com
 (2603:10a6:400:292:cafe::ca) by CW1P123CA0022.outlook.office365.com
 (2603:10a6:400:292::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.17 via Frontend Transport; Thu,
 7 May 2026 12:14:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 AMS0EPF000001A3.mail.protection.outlook.com (10.167.16.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 12:14:53 +0000
Received: from RNGMBX3003.de.bosch.com (10.124.11.208) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 7 May
 2026 14:14:43 +0200
Received: from [10.34.218.123] (10.34.218.123) by smtp.app.bosch.com
 (10.124.11.208) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 7 May
 2026 14:14:42 +0200
Message-ID: <2e1c9a71-46e7-4036-91ac-86453564b223@de.bosch.com>
Date: Thu, 7 May 2026 14:14:36 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: [PATCH v2 00/25] rust: device: Higher-Ranked Lifetime Types for
 device drivers
To: Danilo Krummrich <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
	<rafael@kernel.org>, <acourbot@nvidia.com>, <aliceryhl@google.com>,
	<david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
	<viresh.kumar@linaro.org>, <m.wilczynski@samsung.com>, <ukleinek@kernel.org>,
	<bhelgaas@google.com>, <kwilczynski@kernel.org>, <abdiel.janulgue@gmail.com>,
	<robin.murphy@arm.com>, <markus.probst@posteo.de>, <ojeda@kernel.org>,
	<boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
	<igor.korotin@linux.dev>, <daniel.almeida@collabora.com>
CC: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
	<linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
References: <20260506215113.851360-1-dakr@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260506215113.851360-1-dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A3:EE_|PA1PR10MB8919:EE_
X-MS-Office365-Filtering-Correlation-Id: 3589e9f4-1aa4-49de-5f6d-08deac323ef0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|30052699003|36860700016|376014|7416014|921020|22082099003|3023799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Ss2n2D0GmthDcq3MB7nqhgHdKXbgwQefwLsKh3lFPZA0LCcbiAsrhr+uAEC9OTXK9iAwvR0JaXFtqDaTc3/A+zLESDK7PBOVYdyTCuPyBhd8xG5nj2wt5WODcTQwd94yikOdtvV8HtNRzEr0R8iSx5wwwU3aucWrM/IKQ+tFMHy9QhEfUuVMTYqyJG9m2sbHKAoYvlDzkOnVWH4TnP6SsgExkTlUjOzJDi0IHJuCGMVT2pFBv5uZooozEU2uw8HbUUQbmsImAZsGzbOpzlA9MlzI9aCAFqbyX5g9x+JSdbmrh1K9XrZVKBecaz//wKXOIGFjq00rirNduMOs5tS6n+yo/wxJuUkPBce7OG08MV1WI6nbAesIrYUHyaZYBwXpyMFK6bCy5Jp3TtDSoGvm33WoeFsKZnZeIxGzIO4/3rqbV5zNzpgxI/bmzljvnFrwKEUx2eGJ6AOiK0dR0UlxaYQBJTShuyRaqiZW1OApogn4BHvf8mzhkZNVR638CaoNIXpK5tyklkrCqaFVCHsJIMQC8oLHl/3FtEaMr9xDj4O4Es4nQ+79UcuDAqlUK/sMOtBUmvPe6hojnZ2umae+KJgeyR02aTdsLMrC5a5tk6RoTNYE4QktA4ujyEO6HkVUkGUUlTiqSeuyHnSxbLT95HHFpgEhsFTjgwf8kcULCS7oLT7qXwpKdWGHOJrnz4MEQilOGufSCyujop9/mNt9mKTc1oDY7FH2mKRavedVLH8az1YOp9LXFNlrxhENHdbB9yFkgJgvOMUBfyg2Mhp8u6mfoIV9WX/fIEZAZUa7q2Y=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(30052699003)(36860700016)(376014)(7416014)(921020)(22082099003)(3023799003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PRsQUcVnYgh/AsFc1a1FXMOZLRjZbMQAorEyMcU2coHj9WIHRDQvnPsHKRr/tpDvXsBCEzTQKlpwJ3BXkk0pNGGiejiu4wrjC9hugkZxw4JjvXElUhWOHI5fwojJ0sdat1YLIJytnKACAlaWqHyt9Z78t2xv0JrO+qM38PQ87nFBie917ggAXSsJUaIwDlCVblxjXrq0FTqXqHlZa4kIJj9PYcpOs4RF7UGKc/p/oYX7BQ+T8X86vqK/nNnE7DenugJMwkZMpZ5EywJWgdt4hoGsCx4TWMqkh1TciGmeuM+JmMsBarPehqJE1YEN+44lJ8Q5XIu2jl84nNnuL1wsNSMMUowJL3FL6PXH7jy/FLIvNmUv2TOeT7g9mpXZmQ6hbcE8im7WOFUAFSzVzec3zdlpxZfCDiOdA9glp7nT3PWx34QfoBchk0s16tDUDIpF
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 12:14:53.7088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3589e9f4-1aa4-49de-5f6d-08deac323ef0
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A3.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8919
X-Rspamd-Queue-Id: B28794E80EE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[de.bosch.com,reject];
	R_DKIM_ALLOW(-0.20)[de.bosch.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8835-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bosch.com:email,de.bosch.com:mid,de.bosch.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dirk.behme@de.bosch.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[de.bosch.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

On 06.05.2026 23:50, Danilo Krummrich wrote:
> Currently, Rust device drivers access device resources such as PCI BAR mappings
> and I/O memory regions through Devres<T>.
> 
> Devres::access() provides zero-overhead access by taking a &Device<Bound>
> reference as proof that the device is still bound. Since a &Device<Bound> is
> available in almost all contexts by design, Devres is mostly a type-system level
> proof that the resource is valid, but it can also be used from scopes without
> this guarantee through its try_access() accessor.
> 
> This works well in general, but has a few limitations:
> 
>    - Every access to a device resource goes through Devres::access(), which
>      despite zero cost, adds boilerplate to every access site.
> 
>    - Destructors do not receive a &Device<Bound>, so they must use try_access(),
>      which can fail. In practice the access succeeds if teardown ordering is
>      correct, but the type system can't express this, forcing drivers to handle a
>      failure path that should never be taken.
> 
>    - Sharing a resource across components (e.g. passing a BAR to a sub-component)
>      requires Arc<Devres<T>>.
> 
>    - Device references must be stored as ARef<Device> rather than plain &Device
>      borrows.
> 
> These limitations stem from the driver's bus device private data being 'static
> -- the driver struct cannot borrow from the device reference it receives in
> probe(), even though it structurally cannot outlive the device binding.
> 
> This series introduces Higher-Ranked Lifetime Types (HRT) for Rust device
> drivers. An HRT is a type that is generic over a lifetime -- it does not have a
> fixed lifetime, but can be instantiated with any lifetime chosen by the caller.
> 
> Rust does not directly support types that are generic over a lifetime as type
> parameters; the ForLt trait (contributed by Gary Guo) encodes this internally.
> 
> The module_*_driver! macros handle the wrapping, so driver authors just write
> struct MyDriver<'a> and impl Driver<'a>.
> 
> With HRT, driver structs carry a lifetime parameter tied to the device binding
> scope -- the interval of a bus device being bound to a driver. Device resources
> like pci::Bar<'a> and IoMem<'a> are handed out with this lifetime, so the
> compiler enforces at build time that they do not escape the binding scope.
> 
> Before:
> 
> 	struct MyDriver {
> 	    pdev: ARef<pci::Device>,
> 	    bar: Devres<pci::Bar<BAR_SIZE>>,
> 	}
> 
> 	let io = self.bar.access(dev)?;
> 	io.read32(OFFSET);
> 
> After:
> 
> 	struct MyDriver<'a> {
> 	    pdev: &'a pci::Device,
> 	    bar: pci::Bar<'a, BAR_SIZE>,
> 	}
> 
> 	self.bar.read32(OFFSET);
> 
> Lifetime-parameterized device resources can be put into a Devres at any point
> via Bar::into_devres() / IoMem::into_devres(), providing the exact same
> semantics as before. This is useful for resources shared across subsystem
> boundaries where revocation is needed.
> 
> This also synergizes with the upcoming self-referential initialization support
> in pin-init, which allows one field of the driver struct to borrow another
> during initialization without unsafe code.
> 
> The same pattern is applied to auxiliary device registration data as a first
> example beyond bus device private data. Registration<F: ForLt> can hold
> lifetime-parameterized data tied to the parent driver's binding scope. Since the
> auxiliary bus guarantees that the parent remains bound while the auxiliary
> device is registered, the registration data can safely borrow the parent's
> device resources.
> 
> More generally, binding resource lifetimes to a registration scope applies to
> every registration that is scoped to a driver binding -- auxiliary devices,
> class devices, IRQ handlers, workqueues.
> 
> A follow-up series extends this to class device registrations, starting with
> DRM, so that class device callbacks (IOCTLs, etc.) can safely access device
> resources through the separate registration data bound to the registration's
> lifetime without Devres indirection.
> 
> The series contains a few driver patches for reference, indicated by the REF
> suffix.
> 
> Thanks to Gary for coming up with the ForLt implementation; thanks to Alice for
> the early discussions around lifetime-parameterized private data that helped
> shape the direction of this work.
> 
> This series depends on [1].
> 
> [1] https://lore.kernel.org/driver-core/20260505152400.3905096-1-dakr@kernel.org/


I have applied this series together with [1] on top of 7.1.0-rc1. I made 
some adaptions to local changes (e.g. my ARM64 TMU interrupt test) and 
boot tested it. Several parts this patch series touches (e.g. PCI, 
auxiliary, gpu) I might not use or even don't have it enabled. So I 
don't know if this is worth mentioning

Tested-by: Dirk Behme <dirk.behme@de.bosch.com>

Please feel free to ignore this, then.

Thanks

Dirk


> Changes in v2:
>    - Add 'a bound to ForLt::Of<'a> and WithLt::Of, making the lifetime bound
>      inherent to the trait; remove all F::Of<'static>: 'static where clauses
>    - Drop "rust: devres: add ForLt support to Devres"; Devres itself stays
>      unchanged -- ForLt-aware access is introduced later through DevresLt in a
>      separate series
>    - Use 'bound instead of 'a; add patches to consistently use 'bound for
>      pre-existing 'a
> 
> Danilo Krummrich (24):
>    rust: driver core: drop drvdata before devres release
>    rust: device: generalize drvdata methods over ForLt
>    rust: driver: make Adapter trait lifetime-parameterized
>    rust: pci: implement Sync for Device<Bound>
>    rust: platform: implement Sync for Device<Bound>
>    rust: auxiliary: implement Sync for Device<Bound>
>    rust: usb: implement Sync for Device<Bound>
>    rust: device: implement Sync for Device<Bound>
>    rust: pci: make Driver trait lifetime-parameterized
>    rust: platform: make Driver trait lifetime-parameterized
>    rust: auxiliary: make Driver trait lifetime-parameterized
>    rust: auxiliary: generalize Registration over ForLt
>    samples: rust: rust_driver_auxiliary: showcase lifetime-bound
>      registration data
>    rust: usb: make Driver trait lifetime-parameterized
>    rust: i2c: make Driver trait lifetime-parameterized
>    rust: pci: make Bar lifetime-parameterized
>    rust: io: make IoMem and ExclusiveIoMem lifetime-parameterized
>    samples: rust: rust_driver_pci: use HRT lifetime for Bar
>    rust: driver-core: rename 'a lifetime to 'bound
>    gpu: nova-core: rename 'a lifetime to 'bound
>    gpu: nova-core: use HRT lifetime for Bar
>    gpu: nova-core: unregister sysmem flush page from Drop
>    gpu: nova-core: replace ARef<Device> with &'bound Device in
>      SysmemFlush
>    gpu: drm: tyr: use HRT lifetime for IoMem
> 
> Gary Guo (1):
>    rust: types: add `ForLt` trait for higher-ranked lifetime support
> 
>   drivers/base/dd.c                        |   2 +-
>   drivers/cpufreq/rcpufreq_dt.rs           |  10 +-
>   drivers/gpu/drm/nova/driver.rs           |   9 +-
>   drivers/gpu/drm/tyr/driver.rs            |  24 ++-
>   drivers/gpu/drm/tyr/gpu.rs               |  62 +++---
>   drivers/gpu/drm/tyr/regs.rs              |  21 +-
>   drivers/gpu/nova-core/driver.rs          |  48 ++---
>   drivers/gpu/nova-core/fb.rs              |  31 ++-
>   drivers/gpu/nova-core/firmware/gsp.rs    |   8 +-
>   drivers/gpu/nova-core/gpu.rs             |  38 ++--
>   drivers/gpu/nova-core/gsp/commands.rs    |  10 +-
>   drivers/gpu/nova-core/gsp/fw/commands.rs |   4 +-
>   drivers/gpu/nova-core/nova_core.rs       |   4 +-
>   drivers/pwm/pwm_th1520.rs                |  14 +-
>   include/linux/device/driver.h            |   4 +-
>   rust/Makefile                            |   1 +
>   rust/kernel/auxiliary.rs                 | 132 +++++++++----
>   rust/kernel/cpufreq.rs                   |   8 +-
>   rust/kernel/device.rs                    |  79 +++++---
>   rust/kernel/devres.rs                    |  16 +-
>   rust/kernel/driver.rs                    |  44 +++--
>   rust/kernel/i2c.rs                       | 130 +++++++-----
>   rust/kernel/io/mem.rs                    | 131 ++++++------
>   rust/kernel/pci.rs                       |  89 ++++++---
>   rust/kernel/pci/io.rs                    |  68 ++++---
>   rust/kernel/pci/irq.rs                   |  38 ++--
>   rust/kernel/platform.rs                  | 120 +++++++----
>   rust/kernel/types.rs                     |   4 +
>   rust/kernel/types/for_lt.rs              | 117 +++++++++++
>   rust/kernel/usb.rs                       |  94 +++++----
>   rust/macros/for_lt.rs                    | 242 +++++++++++++++++++++++
>   rust/macros/lib.rs                       |  12 ++
>   samples/rust/rust_debugfs.rs             |  10 +-
>   samples/rust/rust_dma.rs                 |   9 +-
>   samples/rust/rust_driver_auxiliary.rs    |  53 +++--
>   samples/rust/rust_driver_i2c.rs          |  18 +-
>   samples/rust/rust_driver_pci.rs          |  93 ++++-----
>   samples/rust/rust_driver_platform.rs     |  12 +-
>   samples/rust/rust_driver_usb.rs          |  14 +-
>   samples/rust/rust_i2c_client.rs          |  12 +-
>   samples/rust/rust_soc.rs                 |  12 +-
>   41 files changed, 1220 insertions(+), 627 deletions(-)
>   create mode 100644 rust/kernel/types/for_lt.rs
>   create mode 100644 rust/macros/for_lt.rs
> 


