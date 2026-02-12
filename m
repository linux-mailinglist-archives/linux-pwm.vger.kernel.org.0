Return-Path: <linux-pwm+bounces-8121-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFoONY29jWnL6QAAu9opvQ
	(envelope-from <linux-pwm+bounces-8121-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Feb 2026 12:46:21 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBFC12D208
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Feb 2026 12:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BE1D3017267
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Feb 2026 11:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E08434D3AA;
	Thu, 12 Feb 2026 11:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcXQ2kG0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B002C34CFAD
	for <linux-pwm@vger.kernel.org>; Thu, 12 Feb 2026 11:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770896745; cv=pass; b=rb6CzSuFYCeApGfWNtwqBSFcnS4IOPMZnxSNVafDI5Wk1tQiFI9d7e0OAyB4GXwMocIX9f/vMTpSIOiznYRK2Y17KHURy05VA5XogrH0kTz/laY5GFa/wqfiSbU3psSZmbSHRUyb8K1cF3iGyJZ4UWo9/nJr0T8QQGOtQ9DC/7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770896745; c=relaxed/simple;
	bh=aGVkLIr22yJ6JQpgXmUzvygoH7/3iICzBNHCpv+ndoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r6ARnTvId1hWFpRdmz4Z8weQxGZnvAurJev6wbWg9BmBd/MSQs88q7xYUyEgWpUTs6I69/Kq1NlOvHuEhbxJ6HYCUypMk963fyciO8eraw11gev6uVEssztaBk6ji8xKHVLVn7nX625CC9sXXmR9xbuQ41d5KbuiWi7o7JpKwx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcXQ2kG0; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2baaaeeadebso56998eec.2
        for <linux-pwm@vger.kernel.org>; Thu, 12 Feb 2026 03:45:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770896741; cv=none;
        d=google.com; s=arc-20240605;
        b=JQh7Rarlk4PwQP+hU6BGspFjHx7hy5VeyAYeYx0mTxB6FFtH+yALFk2ubpiJfIbwHV
         X8jWfbatJIxFD7IpUjrvwHHNCkHh8EEzD43Kis3dLuGfeUw8iSX8sxp8RuSYxqTWBn23
         Sgf3xUZS2UNVPy2xKBuKT7ieud+npxOrgNv+JJUGvfkKn3aLat8OMOxFx1bfy60zEkvd
         4/mtx8xOsThjW+F71/16kfvTGlk47EIDN7meLg6ZW/NIgKatfNAue+wyaG9Mu28fYzbY
         2ALu67UuznQEJOpQ1xQ+SuIYxzogfimnL9QsSFBpfFgniX6+TKyjjQERKMq5pdnMxqTT
         KqTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aGVkLIr22yJ6JQpgXmUzvygoH7/3iICzBNHCpv+ndoI=;
        fh=ut+1kWTCK3vaANYbFTulTCsrD2f1WILlLyCb6B9WX5A=;
        b=lFVI5S7jtbVLMkIQVuZRz8K7pd4y9gdIbIGvWF5JNiuhqwtfoImYud7mRlyi4WtLUM
         CDsTwW7DO8xlRPluvXwSX5T8W7Md9S2r52jIXdnjHBPFtVHjJjz18wsOYgfrKVwXV0hW
         3Tfib8GWJ3db1rg4PDN4RQ9C9XZULcQ1gbE8Vx++uvLUTh0H3mnvT6u1O0cs+SbADsiC
         uWr+PbE7eSxnJf1R1pLlEPGyrqQs0VxsJsr+rhbSDOxeQ7RSG/HDbsXCeHxyMthhmQzC
         qTcHWFhe9+m5ggFZNnDmNKrYIuaGzPP8SLvinLR8/AwOSAGimvNTzDF/KVYVWEaQ7T6F
         pipw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770896741; x=1771501541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGVkLIr22yJ6JQpgXmUzvygoH7/3iICzBNHCpv+ndoI=;
        b=XcXQ2kG0/4oTcSyjVdNx8+Np+emwCX7SxewOCDoYQO53GU1RfCDS+wbmFt8WJcVnPD
         S3ZGBGfvxltS3SsK8zLuIuBdr4eof35tH4TYPKzywNW1wwYlx7Vt8JxnQPPpmBSL0fCT
         ESYJoYHTkhuJTc3H07AfjOOQ5U5nLbjV4YXmG0VDO8pfsffKkNFkDJbqzk8hJ7/MwIZ4
         n+q7nhmjxJxcAzMVxSCtMU0vMwbxejKEn9280PjektUEpiOCTK/ceXDyO1QCLCRHImqw
         jBranbPi5vQl3qSlT5sJG+VfjFLUmejLYGAjQ9z1JqsCSabyLjcOYdMFrsvJXWmIYi7i
         mwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770896741; x=1771501541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aGVkLIr22yJ6JQpgXmUzvygoH7/3iICzBNHCpv+ndoI=;
        b=KS4V8PAH9iC+rtLtHT1vB+e3s6Q3mkRusuzDIUulrgYb9/MFCoJulZgjc4OQmUasrR
         WFkDjayZliadDpD8EpfEoJeWsKHtEcS6rvczbnCTdVoCGvgRkh0lG3xZGVhBMQ5u1fp8
         7+UVIFW2tRcWEIdtIJ0vrDbZ8F2FBrYuWXlX2AsfVojo2ysiitYIaMocltPgIdCy6Kcr
         sXhHSrMxZtbcphuzzLq/OFuJD/69/kQsvqn1SZamFBGuQPxFPzJS92DbUQOfCgB8CVjS
         38W3b4ugckSJ9o5JPd+xSq4Y9AmODSsgIdInPoed4fMX9Z1Zbm7KfnpjqlM017qXL2/s
         EuuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDcc9oBZF/Z6/JNovAQCi85x07rPirs+KmQf9TNrZDaaAmEFD9yslFd8cXaLi2HomlgLLyC0bYTpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNhntv+DtZQEr0yNs0z+Y2ShQl8hityj/8Nqg0TE9E/IuOr3/V
	+6a8d0WAnsEwRyoNPwlFZ2yrsE5riUiLMNXFwrGeyktnlqBpOVa0vgCjPLEiTSA8py3E2FqN1lY
	Ce7F2wagUspzncGv+11ozNJa1en1q8N0=
X-Gm-Gg: AZuq6aKxvipTfPoqLXTt7k/8RSLgazEAFFNPNvLu1bba/4gvwW/1qIfqBwn3Rr0wvM3
	gr3R3dd8M/mP7nEt/RJRS7r4zWeapn8SVpQlDRF7p6u00sunbNwHoppbUyO4XpQFYVfOmyj/PcC
	Zz6jYocxFWs+l5JRKLiP6rwiQ3qtSPb9fkqq4WajfUCNwDaYIWluBrdsFaBud+TmZPOwsYFif18
	+HQ5L9ijSou0roLKGSDnDRRX+YvXnW5fIY8B1+mAM8xKNL3r2AOM38wjWyRJ+7qJDlmOMZtHEOY
	mTrkdJGKMVF1kSMonQ023CIpIA/W27PxfAPFSEizECBptJJMk1PPkn9NXAdM0n+wcPKsWeBXlQk
	i45mJpOkPxFhDg7BxwGbOzeL8
X-Received: by 2002:a05:7300:aca6:b0:2ae:5245:d50e with SMTP id
 5a478bee46e88-2baa806e40bmr507989eec.8.1770896740603; Thu, 12 Feb 2026
 03:45:40 -0800 (PST)
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
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 12 Feb 2026 12:45:28 +0100
X-Gm-Features: AZwV_Qgkz-xkhnIAg7JBqdav3KKnsGWyI0KDQ-RkibJi23X0-5wEzPLcw-SuW5I
Message-ID: <CANiq72m67XpoE-M2eiJn7RF3LvxRLKZ17YExJJFOFw+H0Bw39A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
To: Maxime Ripard <mripard@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Boris Brezillon <boris.brezillon@collabora.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Alice Ryhl <aliceryhl@google.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8121-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,collabora.com,google.com,linaro.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,redhat.com,baylibre.com,garyguo.net,protonmail.com,umich.edu,vger.kernel.org,lists.freedesktop.org,lists.infradead.org];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7CBFC12D208
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 8:59=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> And the "oh but driver is using the API" is kind of ironic in the
> context of the Rust bindings which have globally been in that situation
> for years. You can't argue it both ways.

I don't think this is true, if I understand you correctly.

To give some context, when Rust was close to land in mainline, we were
explicitly asked to cut down what we had out-of-tree to a minimum of
APIs, which was fair. So I did exactly that, to a point where you
could essentially only declare a module for x86_64 and use `pr_info!`
in it (pretty much). I even considered dropping the `pr_info!` too...
:)

Then we started upstreaming bits piece by piece, getting agreement and
input from the relevant maintainers for each bit, and so on, which
took years for several reasons, one of which was precisely waiting for
actual users for APIs.

[ Others were getting maintainers engaged and involved for some of the
core APIs/subsystems, getting authors of the original code to submit
it upstream via patches was yet another, reworking and cleaning the
code with the new, better approaches we found meanwhile (like
pin-init), and so on and so forth. ]

Cheers,
Miguel

