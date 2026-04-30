Return-Path: <linux-pwm+bounces-8746-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KJJL4Qd82kvxQEAu9opvQ
	(envelope-from <linux-pwm+bounces-8746-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Apr 2026 11:14:44 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 576CE49FB40
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Apr 2026 11:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF86630041FF
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Apr 2026 09:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4F7392838;
	Thu, 30 Apr 2026 09:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oyv8AkPs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC4638550E
	for <linux-pwm@vger.kernel.org>; Thu, 30 Apr 2026 09:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777540482; cv=none; b=kdnQwfGEPd7M0WiD+y6uV0xIT9WMKoxnBCLqEmvqUAJt7x0CCph7hDfCRu3jWZtXDK3bEmy8te47xR/CNTNVLJq3GUbrcMCf6z7Mtds/lIMBW259UVV+x6VoqSl+6ZPQvXBMa8R/VDV5ekLA56Ft2lqN+czszmmLC2lSdgquQ/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777540482; c=relaxed/simple;
	bh=sVifEoF/oe2xdwrFV3e2F++qf+hnysQw0CLe/H5O8ts=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CgI33NTnV2GGEq4Lsb81n/YS9RLTo+eioDTL2tdcArhCxkbO2p8XZhYUkB5LT8DtmLH9t+Kg4LX1D03SWY7jol83x8Q/Ec1/qQM432wSBzZtYFrPr3XaMLOQ0VdBGwtDqXP9BN1EBnX926+Z5bj4cr2zXYthWPo10dMec5eCxXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oyv8AkPs; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-bb9fdd62dceso58475266b.0
        for <linux-pwm@vger.kernel.org>; Thu, 30 Apr 2026 02:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777540479; x=1778145279; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9iVxD0Q/b/KabKpN0s2yCS+iq2LiFZxDqstnJNGVdg=;
        b=oyv8AkPsHabnMIV2gaNFnlzQc7xrQlMZgaZRZv4GDJQcYvMUaXHM/RO9yJ2bc2jj4T
         4vyP02r61SvFmNzPaqqQB5zp4wJ4Jn9GBtoLghe2AeP1rMjKW0mVVLZbVWJaAN1D+YIV
         SRrLurtvNg71bHVocgvwQ638x4pJwSZKEXv4qFJ2ujy8HcyqXKoVZ5n6kC8ZmJ8KqvBf
         i50jTzeHoSSzljxzAMYyN5bDx1uhA7CRLdB4hCJn3XGebZIPGC3wPfJQ6cFj7CQpV092
         GzD2MfH9q63Tn/rCtUJ4JYJbEgu8C6jWe58jefapJp+YktIaJ1zNTjijJi+JpCCw0tUx
         kcPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777540479; x=1778145279;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9iVxD0Q/b/KabKpN0s2yCS+iq2LiFZxDqstnJNGVdg=;
        b=ZIP8x9gV+AtwSXwUK6Jn0hyO3vCInYDMIuM2f8AIdO8IbwUDaZiFuoiDSYY7oB63CQ
         M6/ZKkPxDwdzgh0azlK+LkXSMq//x+lIYHbG2GDA+IVVMgd8vVssXsnQ04dEb8v/ridz
         rbriJxTzn5Vu6SYO/gQ1PYggf3GYgBCojpYF3nxRAIyGUDRnQog52iqxRGJHMdH7VCsv
         weH12u2KkBO2uiSizkan+YmeaWJX+lbF8XyAQU1MkOXDnELb5CThdAQfx6HV0gqrUuaX
         o5tsOu5Y4WNlnHpyddWcsAfnnJPmWF8cLcTV78ePH9hBbI8y/EKjGfCyn5wkypuTb7t2
         jtLw==
X-Forwarded-Encrypted: i=1; AFNElJ/0MxzzdC4NugaTUk7owBk6XqOYm1xt4irEwaqInwLcbMnm4pj/oIdDyFub/daDnavhxQHRdDQ9U+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAvTMd6BVnSyRCg02v85iS2sZslfxX4M5nc/avc4RhxCka0HAb
	TQZQ44FWHOP5NbvfNm0EUNmUk6uVi2zM+DafEQrkl9GUl5FXMcFjCZT/3I5sQG71Hv7Pm2qoKoA
	7cr8K/9V0L3xk861yYA==
X-Received: from ejcqw42.prod.google.com ([2002:a17:906:6a2a:b0:ba5:8db:d6f4])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:7b98:b0:baa:2d37:cbf9 with SMTP id a640c23a62f3a-bbac5abfee4mr145636666b.1.1777540479322;
 Thu, 30 Apr 2026 02:14:39 -0700 (PDT)
Date: Thu, 30 Apr 2026 09:14:38 +0000
In-Reply-To: <20260427221155.2144848-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260427221155.2144848-1-dakr@kernel.org>
Message-ID: <afMdfs0segrRBx34@google.com>
Subject: Re: [PATCH 00/24] rust: device: Higher-Ranked Lifetime Types for
 device drivers
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com, 
	david.m.ertman@intel.com, ira.weiny@intel.com, leon@kernel.org, 
	viresh.kumar@linaro.org, m.wilczynski@samsung.com, ukleinek@kernel.org, 
	bhelgaas@google.com, kwilczynski@kernel.org, abdiel.janulgue@gmail.com, 
	robin.murphy@arm.com, markus.probst@posteo.de, ojeda@kernel.org, 
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: 576CE49FB40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8746-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,nvidia.com,intel.com,linaro.org,samsung.com,google.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Super cool to see this!

On Tue, Apr 28, 2026 at 12:10:58AM +0200, Danilo Krummrich wrote:
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

I think we should establish a convention for how to name the lifetime
early. Using just the generic name 'a is probably not ideal.

How about using 'dev for lifetimes that correspond to the lifetime of
the device being bound?

Alice

