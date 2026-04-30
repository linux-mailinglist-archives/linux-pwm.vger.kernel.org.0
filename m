Return-Path: <linux-pwm+bounces-8745-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NGcERAd82kvxQEAu9opvQ
	(envelope-from <linux-pwm+bounces-8745-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Apr 2026 11:12:48 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D772F49FAF0
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Apr 2026 11:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E89543006B4A
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Apr 2026 09:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4E1394790;
	Thu, 30 Apr 2026 09:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oEqJL9dh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0150939478C
	for <linux-pwm@vger.kernel.org>; Thu, 30 Apr 2026 09:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777540366; cv=none; b=mZKfS4UR0b0Al1q/Wdu5ceZ+5GFO5DimGNqthZQfubS1aCL7Oy1W6XWBwAj0BEk0KX9A7dPXoZ4ADB7EB7f8GuULJ+fbsASe1fpsRmnTqmXs9ZGjg/W0tQ1ycXC6OhpiOMEZNINmwc1YJ+pqHdU1MgSjvY84UJOka4EkmQxHTlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777540366; c=relaxed/simple;
	bh=o3bO4FAjuxVK0962UiL8rrguCj8OrcINAutnD/Afj4c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qLaNW1UT8MEeXda9YtGGOBJN96M9kguhl1yB7QLYe1tTlpwjK+f1BTCgeOqJLEgRIiPcESrf1ydzGSXUKAjcm9IuXhtpH3HNzhh8iLt223Xban6WuWiy/pkp518HLXGQKFSsxntBe2SuNj6HPVR+0kF1SB6b2gK0nWSrWMWqB8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oEqJL9dh; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-4411a215f17so552529f8f.1
        for <linux-pwm@vger.kernel.org>; Thu, 30 Apr 2026 02:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777540362; x=1778145162; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vy8Z/q685PmwcT3tK0xjwvFofcgEB05Cfirscbd47U4=;
        b=oEqJL9dh943pzVc0XpvcL2nBYCSHeF8oC0berfukxf8qxE2wcsal2baoKmcWYugL4x
         GhCRu4H2vjafUhWXCZ7YQ8T7ZruK19P0gMPVNCTSGrzCHB8ylOnGamcs5qcf/P+E/Zak
         bmLU0sSvZQLSlhkO4pZMdDv03xaUYwBCsUUKVeEiuE+bmHV25ivK4gWjyzaD4B5Wm7hQ
         cKWS/vqVhIcITd4OIEe4LYB4AAbzP4tHmDKQTqaaFACHldYef7whDmKYpct7IdVIHggA
         BtFkcmsxWJjaBnvDIxeADKtw3zvgi1i5qVRr4oM2+GPuaYlwb/9VXs8e7imfr5aQUIlo
         dhBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777540362; x=1778145162;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vy8Z/q685PmwcT3tK0xjwvFofcgEB05Cfirscbd47U4=;
        b=p1eyivoE2mhLonqXgsogPCfk4MEgBG0xPk+M31Oa78SVmvJ6g+stZbvS7kHglP4GHR
         QmDe9TgTYVFjwusWfQk+7D6PQjxoJObv+qZSeXQVZ2CAFCDmyaNpYJhYEpvtub7+55JY
         6whNzNWvTCJEjQd2y3q5QaA7sgygsiSBpdgkS+PgHRtX4Yi8sThjPdWM3bBd28m1xzbg
         SmpZzzGeAfwjZa54WkMv0X+2R7sMVbUp1lcWAeDuoDu3LTRm+CKTpS3eX3U/tz5oNehT
         hl2lb2+jqzFeFSLNq1uN9fir7lfpOy7E6R/wFT0wLlNC8HkfgtA/hqGBRhXmuN2wjr5G
         Bjbg==
X-Forwarded-Encrypted: i=1; AFNElJ9KSDfqJlgdJ+sPcYHWTcO9k1efh1ogIua4swCkgwRSOtOrb6GLvaCtJ8qX0yQI2aDxVt8l/RmnHS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR7rsG+dec3AXsz3rS1s0r2H6u/8A1chaLyJP/htw5sLz8P8BB
	JwYMsDerRbYQd8fVyi5dipcbhJPHvMzGAse8RTIZjc8MEVvayeYhNzTJbHCCfhup2tw23eWpGho
	l/+PSGZoO6Xk+HysxpA==
X-Received: from wrtw10.prod.google.com ([2002:a5d:608a:0:b0:439:d5c9:3b63])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5f89:0:b0:43f:e22e:e8da with SMTP id ffacd0b85a97d-4493d7fa1b5mr3355911f8f.5.1777540362054;
 Thu, 30 Apr 2026 02:12:42 -0700 (PDT)
Date: Thu, 30 Apr 2026 09:12:41 +0000
In-Reply-To: <20260427221155.2144848-2-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260427221155.2144848-1-dakr@kernel.org> <20260427221155.2144848-2-dakr@kernel.org>
Message-ID: <afMdCU06-Y2d_LXh@google.com>
Subject: Re: [PATCH 01/24] rust: driver core: drop drvdata before devres release
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
X-Rspamd-Queue-Id: D772F49FAF0
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
	TAGGED_FROM(0.00)[bounces-8745-lists,linux-pwm=lfdr.de];
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

On Tue, Apr 28, 2026 at 12:10:59AM +0200, Danilo Krummrich wrote:
> Move the post_unbind_rust callback before devres_release_all() in
> device_unbind_cleanup().
> 
> With drvdata() removed, the driver's bus device private data is only
> accessible by the owning driver itself. It is hence safe to drop the
> driver's bus device private data before devres actions are released.
> 
> This reordering is the key enabler for Higher-Ranked Lifetime Types
> (HRT) in Rust device drivers -- it allows driver structs to hold direct
> references to devres-managed resources, because the bus device private
> data (and with it all such references) is guaranteed to be dropped while
> the underlying devres resources are still alive.
> 
> Without this change, devres resources would be freed first, leaving the
> driver's bus device private data with dangling references during its
> destructor.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  drivers/base/dd.c             | 2 +-
>  include/linux/device/driver.h | 4 ++--
>  rust/kernel/driver.rs         | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 5799a60fd058..be59d2e13a15 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -593,9 +593,9 @@ static DEVICE_ATTR_RW(state_synced);
>  
>  static void device_unbind_cleanup(struct device *dev)
>  {
> -	devres_release_all(dev);
>  	if (dev->driver->p_cb.post_unbind_rust)
>  		dev->driver->p_cb.post_unbind_rust(dev);
> +	devres_release_all(dev);
>  	arch_teardown_dma_ops(dev);
>  	kfree(dev->dma_range_map);
>  	dev->dma_range_map = NULL;

I seem to recall that we discussed a plan to have two classes of devres
callbacks where device unbind proceeds as follows:

1. Run first class of devres callbacks.
2. Device is now considered unbound.
3. Run second class of devres callbacks.

Is that still the plan?

Alice

