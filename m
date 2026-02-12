Return-Path: <linux-pwm+bounces-8119-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gK3qCvmUjWmI4wAAu9opvQ
	(envelope-from <linux-pwm+bounces-8119-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Feb 2026 09:53:13 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8200412B93C
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Feb 2026 09:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F744300822A
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Feb 2026 08:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B0D2D8792;
	Thu, 12 Feb 2026 08:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tz2xb1Fu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613E2280A3B
	for <linux-pwm@vger.kernel.org>; Thu, 12 Feb 2026 08:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770886390; cv=pass; b=u3bOqifjeGaAVGLB5aDYKqhmYCpmrfKN7CjD3ZkGrbVdHujqxSNWviaVhtCRemztpq9noLFffEiySKW6720EBIAS29czZ0gY4+DhqLlaR9L/7Bz0RR+ondkFgfeoDOSnNl+hGvABPyWZGJH1Tso0f1HWbsjjeoUWlCbjdF37sMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770886390; c=relaxed/simple;
	bh=TjJc1hC/5UC/8qaSpl2SUPNI7E36+gR+pLp/bXphh9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OW1zknb8xlwNoXfsIWK6yHgepEQo8zL6fJL2MDUjrH9Rh72BOHp3N2BgSoy6fvwHEfRG4d9xWdydD8TprpZPY1qSaaKSTUkxKXwAOJizOa1cDrxq/rVdPij5AK34Bbnwf2NbaYZ7TYb//B3PIrQgGRhtXQD6R6omtdfuXYO6xrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tz2xb1Fu; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so42474375e9.0
        for <linux-pwm@vger.kernel.org>; Thu, 12 Feb 2026 00:53:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770886388; cv=none;
        d=google.com; s=arc-20240605;
        b=HKiV4vllmiLwkegGArkCxWY8ZGX+9G3+QGF+lU2MzJMXuWR0DxEDZFTlz2lScaPD1F
         yzApG3bGU8u1SY/jVIxUtremW5rcd3tbKQm0OpVkP30P0vCBd8lxNy05+NEDZsfAFwO4
         ZewGU3AgBnULT4fCKCXNcImf03mXkNLVLTmM1txWOEvXlKOjMXiMpMrS5OjQqSC4VoVo
         7U8oxH9ybt2/5NpmWUpLKBx53uKrYf7K4FhUvJhYDmNEEHUPDajt8XvcIweIjMvwhkXS
         RZsimgwDFbDYK0/kb+H45iOSMsfQ05dybKqdNMn/9ZRtV1X5YSqMPeqrvsd9l048gK4y
         XtFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TjJc1hC/5UC/8qaSpl2SUPNI7E36+gR+pLp/bXphh9g=;
        fh=HoHVlwqQR06/dOObqwLYJNgs39x6Xn1/1QI/8/t1biI=;
        b=h2TcCxhfHlg/+jHWY2jl0Mms5DQiv4ugoM7EIQ3KBdh/3RphZVGfW6fv5rTpjFDb8n
         oSBFpnj7jJKWbaN2yhEEqz8xe/PEhdpzvGRfjtZF4w0AyTAgOhCTkD4VX+v8WaiEZ52s
         uAqUehhcUEA9rCza4zfYD5fS1yjFTP4ul7ZKkGnCtypQVqlD3U3OeDh3nD/OHG/pD7Ug
         AN2fLx2tmT0jtW+49fnCRvm2Nn5N2w/kYxCtWVWER2gUTSuV8ifIxpuynp3yCSMF1Wk6
         C0h6P3jO8ySjLSJFMxH1j0uN+o01fvTB/e02UY0H0YCACnL+O1IswBjavVj4ggn8e2x0
         rZXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770886388; x=1771491188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TjJc1hC/5UC/8qaSpl2SUPNI7E36+gR+pLp/bXphh9g=;
        b=tz2xb1FukJ8IwqH5vPBDKiArb7vDXeWccfAGLURwfoqDOK3rhUSIHhZysV0Bqo4WJ7
         4q1EaiM93bfDUz/KhRl4TYbzZhylynP1AKRTFz5zcFQH2UB0cCk+QThhTPCGRnYtvprR
         BLFKZ3uSuxppePrfyabtf+2kW3sWDrZqdZsYpE2npLLk0No4n2TDAoImjo46JcgOxBhF
         dTiUyEfsRSlg7VobqKrU/4Ehr0W/SGyRP/UKcJhSTBjRtz3iwQ8+ROklCqq2+QGCAcee
         ji+cqiODORgmk6JkeP43alph8IyjYHZBXNwpK+rv67uO3DKA1MhX/4OhKueHAf7iwcfZ
         0ZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770886388; x=1771491188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TjJc1hC/5UC/8qaSpl2SUPNI7E36+gR+pLp/bXphh9g=;
        b=ZkPwd46Sxs6vRYUFbU9isf3BLMdWc1LEjyop/ZQ29rkF9j+/5bkUtFbYs61mFo46bB
         0pHhBmQ6u5VaT5OPA9IM4F9NriehVzprWIz6Bu+0GUdH8qeDVIaSLww+GBWXezQTEOGA
         n3IkjSVZEkxnGXe+gZuudC5v2Q2bp3Vhw4uUnv72v3Bs4ovC9xiAoq7j4k1/bVk5V3+a
         eQqcbt4NgsjDuHw/K6RnG1kedxmfbXQ4pJ5Ng9FhSdhuHgJqCUKIs2s0KcBLdXJ6DZuY
         qkqNAsWOn0QSJ/N60Pdgmv+sCiNXs5EpyCdrpl8KiXxWyYKh2QpHpDUQpuMqFCpqALdO
         pQ0A==
X-Forwarded-Encrypted: i=1; AJvYcCWg3WBYiGj1xMHdSBi0kupYyKZumMYHE/B3+oGaA5FZoAuJUItVc+F3JWv9z5NtnHWcqttUoEZlCBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzViSNYLYmTxOiFBmP632lbKQgZyjzaqPw0bx3AzsT7pGGsjn5m
	Rx965BoD22Y7tRB4YHdqx3WgSPMlT5mF1xGj2ngoHTClpu+GE1Cay0EX02b2hvUAU97WcMK7f4l
	UJK+w7U3iIDVDrKK3eGVIGtLUHNwn7x56LimRFjRb
X-Gm-Gg: AZuq6aKcK7A+VATJ8DjH8W+fTX+HlI6apgRGcsv0VC5dCJo9GH+55GxAicUPkoWzKDX
	Yfc3W8t6MQxzSqrkMNxMC+TjGZFCAdkwdVCH7TMtfLdp/Ow4QCs5og71ZCfg4DU035cO0la6Nye
	yfNti2AanDh79x3zCAmKOnbkyyYmEG/rJjK21yXasuCkgklK69aY4nuxk78hOes4UOgMfFFjNZF
	CRrTK5plg3lp59e2chTeWLaUHtUsRCZrLsyyvY6oFlkzQOKTJOZSlO4RrdxtypJgkvZ8S/zN/TI
	w9JV9UE3tmKBScTSEtW6LZCE7e/lyFhDF/h/yA==
X-Received: by 2002:a05:600c:a0c:b0:477:6374:6347 with SMTP id
 5b1f17b1804b1-4836715615bmr17466765e9.22.1770886387455; Thu, 12 Feb 2026
 00:53:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119-weightless-pelican-of-anger-190db0@houat>
 <DFSN4FDCYHMW.3J3237PEBV2ZP@kernel.org> <20260122-majestic-masterful-jaguarundi-d0abde@houat>
 <2F3D3A40-6EF9-46FC-A769-E5A3AAF67E65@collabora.com> <20260204-nickel-seal-of-poetry-8fdefb@houat>
 <91A92D84-1F2E-45F3-82EC-6A97D32E2A78@collabora.com> <20260204-angelic-vermilion-beagle-fd1507@houat>
 <20260209105047.693f2515@fedora> <20260211-flawless-feathered-boar-0b87ad@houat>
 <DGCAAE4YEDLO.299F5M641E90B@kernel.org> <20260212-obedient-faithful-koel-d8aaf6@houat>
In-Reply-To: <20260212-obedient-faithful-koel-d8aaf6@houat>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 12 Feb 2026 09:52:55 +0100
X-Gm-Features: AZwV_QhgJnsuH1kZOi2k-I_YfnetcmGyr_LHt3UuVnGbxnKyOqJh-xBICfTM86Q
Message-ID: <CAH5fLggWdQ04fVjmcNcNYvUTx1zTqU10usFbypPV+fe3OpwbkA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
To: Maxime Ripard <mripard@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Boris Brezillon <boris.brezillon@collabora.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Drew Fustini <fustini@kernel.org>, 
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, 
	linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8119-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,collabora.com,linaro.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,redhat.com,baylibre.com,garyguo.net,protonmail.com,umich.edu,vger.kernel.org,lists.freedesktop.org,lists.infradead.org];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8200412B93C
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 8:59=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
> It works *today*.

The code we have today is both safe and unsound. That is a bug, and it
*must* be fixed.

> And the "oh but driver is using the API" is kind of ironic in the
> context of the Rust bindings which have globally been in that situation
> for years. You can't argue it both ways.

I don't really know what is meant by this. This API is for real Rust
drivers that have already started landing upstream. Sometimes we merge
APIs *before* their user lands, but not without a user. We generally
are quite consistent that Rust APIs must have a real Rust driver that
uses it. It's the usual no-dead-code rule in the kernel.

> Either way, I'm not sure what the point of that submission was if you
> will just dismiss diverging opinions, including attempts to compromise.

It is true that we are unwilling to compromise on the requirement that
APIs must be sound. It really does not matter how convenient the API
is when it's this easy to get it wrong and decrement the refcount when
you did not increment it. I'm sorry, but that's the way it is.

In your latest email, the suggestion came up to make the API unsafe.
That's more acceptable, but see my other email from half an hour ago.

Alice

