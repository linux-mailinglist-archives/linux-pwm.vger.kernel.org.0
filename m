Return-Path: <linux-pwm+bounces-9077-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOc1OVAuEGqSUgYAu9opvQ
	(envelope-from <linux-pwm+bounces-9077-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 12:22:08 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FE75B1F96
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 12:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C55453013D51
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 10:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31463C81A3;
	Fri, 22 May 2026 10:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nXG6ZvjM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479822C028F;
	Fri, 22 May 2026 10:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779444894; cv=none; b=BIp/ihuxUzBD0ywYR0nmPwIreKSLAUXhlkQmOdah3/dabsKDF8mt3yJJqFnxvI5GI+JvLvjIqHWMHx8+cBrzJT4p89pw9Vv+uKvNw++bv+Ld5r70oS2gKmLzZzQ5aIDmJr2NlrUnPZnDFpytcMUQmQXRVg4v1EQ5emSdHT8t6ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779444894; c=relaxed/simple;
	bh=D+6rf656m/h7dS7mrJnYJ8NA6/KHGVnvnPJi0IdIYq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppXDKvZFbYwZJ1uvZNlhpaCp7j9G4MgAbzYlTbdXH+u21eJzpTmHeIpFuBj9padP/TK1zzKFhMjG+flbV5Rt+qedGI8BBldT0386qsb7DyGxBP29r61QcSumBxW4ABjFR4YwDFuL4Sj5Du3Nrn4zdjYmK9dBN9qmkS83qoLRPb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nXG6ZvjM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5601F000E9;
	Fri, 22 May 2026 10:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779444892;
	bh=+eWdPqbw9hijCK3kUnucObPuKy2/QFassSDTi9MvW1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nXG6ZvjMkL4RnuznluSVfMxziUgYDGWEo/8JJIuAyvynQ9L4UP3As0XhSQn9oz5VY
	 OlTRs9/rmRISvVCOnTxwZK2r3Fm81kDDf0f3wG58me5MIw+eyTDIMyOyO/GHGdO0w7
	 HYylR9uWY2Vy+gvLx++GoZLYPzz7Vto7Ujxrxfwg=
Date: Fri, 22 May 2026 12:14:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: rafael@kernel.org, acourbot@nvidia.com, aliceryhl@google.com,
	david.m.ertman@intel.com, ira.weiny@intel.com, leon@kernel.org,
	viresh.kumar@linaro.org, m.wilczynski@samsung.com,
	ukleinek@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
	abdiel.janulgue@gmail.com, robin.murphy@arm.com,
	markus.probst@posteo.de, ojeda@kernel.org, boqun@kernel.org,
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
	a.hindborg@kernel.org, tmgross@umich.edu, igor.korotin@linux.dev,
	daniel.almeida@collabora.com, pcolberg@redhat.com,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v4 00/27] rust: device: Higher-Ranked Lifetime Types for
 device drivers
Message-ID: <2026052242-geranium-disfigure-cfaf@gregkh>
References: <20260521233501.1191842-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521233501.1191842-1-dakr@kernel.org>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9077-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.935];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 41FE75B1F96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 01:34:26AM +0200, Danilo Krummrich wrote:
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
>   - Every access to a device resource goes through Devres::access(), which
>     despite zero cost, adds boilerplate to every access site.
> 
>   - Destructors do not receive a &Device<Bound>, so they must use try_access(),
>     which can fail. In practice the access succeeds if teardown ordering is
>     correct, but the type system can't express this, forcing drivers to handle a
>     failure path that should never be taken.
> 
>   - Sharing a resource across components (e.g. passing a BAR to a sub-component)
>     requires Arc<Devres<T>>.
> 
>   - Device references must be stored as ARef<Device> rather than plain &Device
>     borrows.
> 
> These limitations stem from the driver's bus device private data being 'static
> -- the driver struct cannot borrow from the device reference it receives in
> probe(), even though it structurally cannot outlive the device binding.
> 
> This series introduces Higher-Ranked Lifetime Types (HRT) for Rust device
> drivers. An HRT is a type that is generic over a lifetime -- it does not have a
> fixed lifetime, but can be instantiated with any lifetime chosen by the caller.
> 
> Bus driver traits use a Generic Associated Type (GAT) type Data<'bound> to
> introduce the lifetime on the private data, rather than parameterizing the
> Driver trait itself. This avoids a driver trait global lifetime and avoids the
> need for ForLt for bus device private data, making the bus implementations much
> simpler. ForLt is only needed for auxiliary registration data, where the
> lifetime is not introduced by a trait callback but must be threaded through
> Registration.
> 
> With HRT, driver structs carry a lifetime parameter tied to the device binding
> scope -- the interval of a bus device being bound to a driver. Device resources
> like pci::Bar<'bound> and IoMem<'bound> are handed out with this lifetime, so
> the compiler enforces at build time that they do not escape the binding scope.
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
> 	struct MyDriver<'bound> {
> 	    pdev: &'bound pci::Device,
> 	    bar: pci::Bar<'bound, BAR_SIZE>,
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

Looks nice!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

