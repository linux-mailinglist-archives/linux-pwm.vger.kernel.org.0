Return-Path: <linux-pwm+bounces-9433-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PcIlKSetP2pjWgkAu9opvQ
	(envelope-from <linux-pwm+bounces-9433-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 27 Jun 2026 12:59:51 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A24C06D1CD2
	for <lists+linux-pwm@lfdr.de>; Sat, 27 Jun 2026 12:59:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="LTCC5J/A";
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9433-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9433-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B647A300A272
	for <lists+linux-pwm@lfdr.de>; Sat, 27 Jun 2026 10:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D8F3ACF05;
	Sat, 27 Jun 2026 10:59:44 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531FA3AC0EB
	for <linux-pwm@vger.kernel.org>; Sat, 27 Jun 2026 10:59:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782557984; cv=pass; b=AXzTR9u+qlml+nAXhcrX0j0jpcAYnN6Bb10Z+1qakqf/awPqVPuFYe0NAUspUWYO5WVMN8TOHlEDP2jG+GrIy+JO4JMSOqVBTpRFVYsBIwBl5WyU/gsD5a3pJWV7ZUwFUDNgfwV2h2nn0J3jG/SokJajqGOawsHZjYswUSImNP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782557984; c=relaxed/simple;
	bh=n+nDLLPZ6wEr/4dq0uqyhXXPZoefpLj+VqCWxHyZNrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p4V/5uIviQRdHQBzwPzx2oktnQ1DrRNrfc+F2475mxd3ASUxRaJ35xhSJWjXgvWXkIv0I4zaR8Yhib/n0GS2OEX9dzmKYwjyQzgAMsPajbIyt9nbHfWJiBoWDX4jGMPrbhqtn4M7W3ngTqXnUqIMw1RwbPP49dmogfHHudiapq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTCC5J/A; arc=pass smtp.client-ip=74.125.82.172
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-30df5822465so13775eec.2
        for <linux-pwm@vger.kernel.org>; Sat, 27 Jun 2026 03:59:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782557982; cv=none;
        d=google.com; s=arc-20260327;
        b=aLloeGErgYndvFn1vH2zx9o+A1kf5cHwsfd5WToJfzvrihZin2KcxJCRFQ1VONsHx7
         UTfYO0vC1nTn3HHzhD3Mvl+AwRHUVHvteUgzokKxjzqofXoS51XwYr7lEeaiiH9LCi3P
         oQk1m4SSdsLYrCSZv7/9W0fkfCrvWgu+M+6PMYtRHWeE3cEu+JUJTme79JGxr2cK6Q3K
         cpP1yfkLN4j5CBImtVMKO1E3r5QdUQts0KjFnD5tZ7PMgYyr9UtfCslXUqixpJ5Vz+F4
         5XmswFXC0bk/upvUwHdBpXrJsfKWzMHsndBsnUzgSRDSHP0wGaABDt/tm38AfHkIuBDV
         jblg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n+nDLLPZ6wEr/4dq0uqyhXXPZoefpLj+VqCWxHyZNrQ=;
        fh=4SX2PgfeyWCgsSjsuGLuwlmvzJK/V2FyC1mwz/nt3zA=;
        b=mbqX+yamBhNk2BgtHf2YchSdcd1L4D87jSmdtZPRSh8b48MHQIThuKc0fYVb5DmzYW
         t0/npuLEH3OyLdsyOgV/ST0WDT4t2igbf0HpZekwf8Lz8nxZt2OIRs6TOLoytsBrDaB7
         UMFV+A6E9NX0SlYP4rKRQRNYzTBUa2y2GPIQ4xG5gExmwh4TepIiK6zK36cD7jIbo4no
         mmP2/KZNN8oiwzV0spZ42wgvH0NB2Rf7lXvFciPXqUeK3vqM8feOKsjlKQP6SMUz1Pun
         cRT1inqm/GzC8ie8vb8wQzZ5sfMDrlqzB17S7cH+21CnIuWouMTYyJg/qr2eW8LDzgIJ
         RTog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782557982; x=1783162782; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n+nDLLPZ6wEr/4dq0uqyhXXPZoefpLj+VqCWxHyZNrQ=;
        b=LTCC5J/AlHwNTPg3a/mufaYZZQPgXwVTgs8fczt2lpRLNdTwoqGRwRbAMpfKUYBqRF
         tS+tNysbuvGGWZzcCg+xlQHqX6oxURMOkm0IBSolgrgzokVninhfx9uT68qbSBthVTUX
         b7FYU3JxaNZyP17nYb4cQCoOeiZempuB+c86YataOpL/Hv8EaNKn3WUyYRfSKzTRbrQF
         uGDgTU8R83YbRtGgCiqUNEdyUb6PJ55IWB1r5Nb2Tx08r8w78OF7EKKdmjW+YLvEPoLV
         fvW/aaULnlXJ4iZ8cIZoBbMK0rOoNWgQGCYROfV4m+nLdPEOclvLuVSGxmo9MxiX5+Dc
         P6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782557982; x=1783162782;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n+nDLLPZ6wEr/4dq0uqyhXXPZoefpLj+VqCWxHyZNrQ=;
        b=XSSnP6qTfoqp7vVA6jc+NyLKEo+U0wdviBexu7SpFrt2fY9wsDN3BuyNEdHq380zwi
         CW56mrdM71bKUcaJKS5/m03u1aQNvWxrBh3kyKj0KxbTVLba6PbupdwC0M0at29LaQ2E
         i/nfJUjTdO0NlJO4gGM/CqP1xJwsW5IiIHrQ9+3sMfdsUWDWR69GzUKy7qZ1sLPc0lQi
         1x5wMfgOD53iWQiACt+8Zqj7zoEuJ6VRPFMww9fdIBVfOelaEFYXPkU8FQ7p/8/tsTEO
         qWMZZ2l1TsNllH2PuBckZjrI8JPF4ww3GR34ZuOjq2sK0SJDRPHuhv79+Vkfx1Mz2Vxo
         RE9Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro+Jd2dpLBFtt7z/IENGYowA5mKfo/mfnqE2t30aGfBV3et2AVX3qd1KrJIluCg6n18sq4pfLNwjMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypz1dCr36Znwet5s8U/fdhdZCgWMQi0Rnbx+MNTT35CzxpxFwY
	c5W6xDkICG4vJvoPIAtnD12+6MJU0kJRtBLpAc2qo5kUtw23b9HiNdotU8UPI3thv/mN4okLo7M
	V4XCl7gj7MEyrclTf7OUjL2k4XmscyhI=
X-Gm-Gg: AfdE7claJoMGi5ebSvrywPH2THKUN2a5oixy2wUSxOyOTn2WbXYTs2Q/fuRAXcXgklH
	7rekA/y/6HDh+7gIe4zKutXqcN/LaEgM4XiqiWoosH49NxBlCI2UoKLZ7Pvl0x2NX3a78dGvIN9
	MFY/d4fjLCZFXO4kr6heBjsW+jQCd3dlJwmr1olzsjpO0wd44x/RP5Bqq78EfskRSAWYXpQkMo4
	1uCdBDNSVbWrlGWaTCSk10I048OewGNa9UaYVeoDhWzB4qQmSs+OCRMI4KMH7cvW4ofcKkUQLnA
	Y1PW8d0exh65uk8tDdVsz/yABklT32yN0jqcECM1Q9bgVz79HLoejoP9r7RHHGOqNUUWlNG7w45
	hC1cs0iaeCf3K
X-Received: by 2002:a05:7300:6144:b0:30b:c021:5045 with SMTP id
 5a478bee46e88-30c84ce60f7mr4014070eec.5.1782557982397; Sat, 27 Jun 2026
 03:59:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626183630.2585057-1-dakr@kernel.org> <20260626183630.2585057-2-dakr@kernel.org>
In-Reply-To: <20260626183630.2585057-2-dakr@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 27 Jun 2026 12:59:30 +0200
X-Gm-Features: AVVi8Ce3MkIh0ONlyKuy1KTbQ-yG1BEWeg6mkrKBipEfxJFXZQzFaNA4SZvKL0c
Message-ID: <CANiq72mT0sAUX0Ob0RHzqS3QOzRxkc9=UoOuPTTyH=nAa8D40w@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] rust: types: rename ForLt to CovariantForLt
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, acourbot@nvidia.com, ecourtney@nvidia.com, 
	m.wilczynski@samsung.com, david.m.ertman@intel.com, ira.weiny@intel.com, 
	leon@kernel.org, daniel.almeida@collabora.com, bhelgaas@google.com, 
	kwilczynski@kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9433-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dakr@kernel.org,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:acourbot@nvidia.com,m:ecourtney@nvidia.com,m:m.wilczynski@samsung.com,m:david.m.ertman@intel.com,m:ira.weiny@intel.com,m:leon@kernel.org,m:daniel.almeida@collabora.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:rust-for-linux@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[miguelojedasandonis@gmail.com,linux-pwm@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,nvidia.com,samsung.com,intel.com,collabora.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A24C06D1CD2

On Fri, Jun 26, 2026 at 8:36=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> Rename ForLt to CovariantForLt to prepare for the introduction of a new
> ForLt base trait that does not require covariance.
>
> The existing ForLt trait requires covariance, which enables the safe
> cast_ref() method. This rename preserves the same semantics under a more
> precise name, making room for a weaker ForLt trait in a subsequent
> commit.
>
> No functional change.
>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

I don't see anyone else in linux-next using it, so this is likely fine
-- if we expect others this cycle, they may need a merge.

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel

