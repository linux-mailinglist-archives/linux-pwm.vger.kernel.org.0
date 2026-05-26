Return-Path: <linux-pwm+bounces-9163-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGoqBrvsFWogfAcAu9opvQ
	(envelope-from <linux-pwm+bounces-9163-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 26 May 2026 20:55:55 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3075DB9D1
	for <lists+linux-pwm@lfdr.de>; Tue, 26 May 2026 20:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1F83307341F
	for <lists+linux-pwm@lfdr.de>; Tue, 26 May 2026 18:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC5F3BFE24;
	Tue, 26 May 2026 18:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/gtWsTx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB562DEA7B
	for <linux-pwm@vger.kernel.org>; Tue, 26 May 2026 18:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779821370; cv=pass; b=rjDIJ7CVoo2x+1Xs7/YR2L15ZZWW2GjUj9YqGs8a4aALFrQCOBjhFkw4xF4S6EZlVZh18dEixYneSII6SL4UWbD0FuvW9UkZPHjJod/ljHX6pewCPnQaH6CJZTpFcVBJzg8ovRYmte/cKwD9o6uXXXBZUhHPW4PmliGeODYFndU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779821370; c=relaxed/simple;
	bh=Ee8xVylefUxsgAC7/wUPXBUGosnDj2MjwQFydFBfjuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JVj5kM69yZWA6H8hr0anjTkoeZiFqxzAhUw1wu1ddZwmlOpEtjwqEkGzl0LHqYUbNGJh5oiPW4Z+Pa2qDUzxIgxmgiEVc6/s/+oJ/rJQfQXpMi2XSEkbGQFfZIiYA9ypNbmpZb2no/jmVq8CAGKtFUlRFbUfMXHRyPD3SDJKL+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/gtWsTx; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-30436e8f582so595455eec.3
        for <linux-pwm@vger.kernel.org>; Tue, 26 May 2026 11:49:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779821368; cv=none;
        d=google.com; s=arc-20240605;
        b=MG2kPhCl6YdxL11cUaqY+WDmuXqvWS38URUHxY+PaG+f4q/YxuBhfD7HP+YDs8rCDt
         +DuscPbnhRhcFZo7ILc1Gpi+XVxCNEEENZ3frjGbMltXf47VoJ5ZIapxIEvuHXfto9iK
         ixriLOZGcNUg9NqfKlEi/V5Dcg4pN58VUHjQPgUXGv0LVuoMIXUogArHIIdPSB68RTPy
         i/IsAttIgb1MGyfztZUvLSc5M96VwVTGRV8IYhJwWGu22IljNma0wNNMY8qSKKA2HCBI
         5rf/rgX4//lct0x11BSldl4SVYnVuT0JDSVOzu9UmLz6kKArjax+SD0NSo/hyvaz5fq5
         K7nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gq/O5ZHqDltDecbFmxpc8E+jT5oOcbB4Yuea57wtwdA=;
        fh=RNV3FoUmlNZXauEQjISq3FcZK9X5pirO4Z5e9Ga99OM=;
        b=fS1/dZ0Yjo2pbvkVe4mTzJOpmULrrTgbgsS/UxPEbqoVUJ7HsPecTJt0zIsgHMgSih
         /xVA7eGy80yXxbYFh+QVwqx++BOYr1LNeOkViFPH5UpLAYjQDZPQQI4JhA/l4YBZCE7N
         QGlYY/TwGojX9tzvkr+R+K04XkSkxkGFhESPhvgmgqtuOK0wFjGbPb+Hy7yH0zD3RLhG
         85VW7OvB08t4BrUTYExCycCl3uscU7paWutL5tXwlowAcUfI91FPAqb4KcMcxTxTEDHL
         OV9quh28hb4aoLhsaB1YwMfCJkl451uBsZvKmz6aiwZn2/EB2o9N/XeB3+lOiWKTs0Ow
         HifQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779821368; x=1780426168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gq/O5ZHqDltDecbFmxpc8E+jT5oOcbB4Yuea57wtwdA=;
        b=H/gtWsTxLU0K+b4gFr28hm1M2IqFsQtp4OhQbOtWzR54nA/ZWN3No/6X/dzvj2sjCI
         tI1SGQ/6hvbxgGEa4S4DaMWZ2UZx2QHLMa/SddknnO4shgZFUzr1qjKX5H6YqO/YltR1
         R2KyKjtM5f1mOQxdlutG4DMBrlXHvM61XCxRtqLq7Z41pZjXRwrc1fhoC5JoDq7Lzme9
         XfmcQrhbEUshzeGkdyJRCHqfeuxp6qaxRBJ1PTfswoFhRD8OiVJSjIDm3ZWlwJ4SzMkp
         i0Zy4SaYI+HOJ/7EgzgfiDlPLcjU0bM7xMZv50tVSH2f9hM00/tvYeQscvP7+VM9a4II
         nHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779821368; x=1780426168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gq/O5ZHqDltDecbFmxpc8E+jT5oOcbB4Yuea57wtwdA=;
        b=ZRK4J1NY63adTqzXztPWEMGLMjFbdbdKSz9o4rtQWizny4wt+BvYIQGl0p5hrSPrH1
         AZeKQ/LrMtCsIuHXk9Q0srebUtSofxEQTkwJtpoP4i7Zrxo9Oe/Lwm1IkrawBa9F8k5Q
         B5HBQzq6K3KLydxYKH7IMkSp/PRK5ZvYlzHekuXkcMWOXrlNGHCJAtn+QmnYpEj3ct+A
         7qVK3OuSrAzAzx8JXWueTMB3HDHVzDfuI68WzlQZiYDxPzxfVsvFmCjAlliMqFPfEOZv
         uW2JbucD0DBJlnIzioFpSy2DBg+8Zq7ZdsNrXIBtL4fPc9WbJXwkQZ3u8bDv3/9ur2Bn
         z/1w==
X-Forwarded-Encrypted: i=1; AFNElJ9A8iizaZGtAhQlUk/W/1+u0ml0sGCYlDxOVjtsubEWHW+LhGJvnIZVQoxIAk9Qz5CwIc3w4RVZZLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXzcewv1dSOZSul2hS4qPEMzFzVm0XQVBOuuzv4Mx9ZlmPhKCf
	9RAlO86h9+FTBNkFjUSFx2eyEiUjL2q/95jc8+IEvcZwwtJz/iEvEIWHQ+nYvZPDjqTdEH+muBr
	0C7CKYkKJnfge7tYiywdauieTMuf4LTs=
X-Gm-Gg: Acq92OFxs3bH5kMG3S4gMnD03Kym8R8eh5k76GYDKlQ16w7mlJsnlykuTcO2LalkSG+
	pMyE70EwQKT6/YqcmEBw4w8nkmyQWMkF+7s1Q4lcmz/7W1M1cDgG4IxKG3bBK+NRlWZtrxBA/Sl
	W50is3khPCwU/m7swFqqRwclKOslza9aQz7OgRHaVpnqMEjJo/ULXqOQY6BfBHipGpXji0GQY4Y
	Yqm8pTEm7wYRFZ331cAaeRzB54X8r/CcTc+B0bhPhYWN8/fbP9qFCEXgPUZwuUXAmiYfkGgNjaj
	6A3JgSDsSNuBcy1VDRRd7iOCdW4/RQ5j8yY7fjtqdUpSchTv9oq0q9L/zQxt3mmjRlQdZZSAKaY
	Cet8cTA/Ofoyvo9Cnu94y1Lc=
X-Received: by 2002:a05:7300:5711:b0:2dc:e799:934f with SMTP id
 5a478bee46e88-30449099a11mr4340063eec.3.1779821368216; Tue, 26 May 2026
 11:49:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525202921.124698-1-dakr@kernel.org> <20260525202921.124698-23-dakr@kernel.org>
In-Reply-To: <20260525202921.124698-23-dakr@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 26 May 2026 20:49:15 +0200
X-Gm-Features: AVHnY4LynmVmerdJFsxXUCWY1urLy48wQB7u14V2mO2sDmYd9U9x9x1s6x7Cz50
Message-ID: <CANiq72=iLUncNw35tpRinUt15W0aqsEiNn+rMcjC3VGq0gx0Rg@mail.gmail.com>
Subject: Re: [PATCH v5 22/24] rust: types: add `ForLt` trait for higher-ranked
 lifetime support
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com, 
	aliceryhl@google.com, david.m.ertman@intel.com, ira.weiny@intel.com, 
	leon@kernel.org, viresh.kumar@linaro.org, m.wilczynski@samsung.com, 
	ukleinek@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org, 
	abdiel.janulgue@gmail.com, robin.murphy@arm.com, markus.probst@posteo.de, 
	ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, igor.korotin@linux.dev, daniel.almeida@collabora.com, 
	pcolberg@redhat.com, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-pci@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9163-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6A3075DB9D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 10:32=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> +/// Representation of types generic over a lifetime.
> +///
> +/// The type must be covariant over the generic lifetime, i.e. the lifet=
ime parameter
> +/// can be soundly shortened.

I wonder if we could keep some of the commit message around here -- it
was a well-written one!

> +/// The full syntax is
> +/// ```

Nit: we are not fully consistent treewide about this, but please add a
newline before (and after) examples/code blocks.

> +/// ForLt!(TypeThatUse<'_>) // Equivalent to `ForLt!(for<'a> TypeThatUse=
<'a>)`

Nit: please end comments with a period (most in the patch are already OK).

> +        // https://github.com/rust-lang/rust/issues/152489

Linked to:

  https://github.com/Rust-for-Linux/linux/issues/355

and tagged the issue with our label upstream.

> +    // Currently the Rust compiler doesn't check this, see the above Pro=
veWf documentation.

Nit: `ProveWf`

> +/// Obtain a type that implements `ForLt` for the given higher-ranked ty=
pe.

Nit: [`ForLt`] like below.

> +/// Please refer to the documentation of [`ForLt`] trait.

"of the"?

> +#[allow(non_snake_case)] // The macro shares the name with the trait.

We normally put comments on top of attributes, but if somehow that
messes up the formatting or similar, please ignore it.

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

