Return-Path: <linux-pwm+bounces-8397-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFHWJ3XBxmm8OQUAu9opvQ
	(envelope-from <linux-pwm+bounces-8397-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Mar 2026 18:42:13 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBFA34887B
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Mar 2026 18:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE4C8300FB50
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Mar 2026 17:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC67C3FB7FE;
	Fri, 27 Mar 2026 17:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alhZHxPV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAC63F99ED
	for <linux-pwm@vger.kernel.org>; Fri, 27 Mar 2026 17:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774633103; cv=pass; b=t5FS7fQsvLa3drAF5sckBBTU1Hwy9SDuesl38a8zvhaUiu+lmiV5GC/97tXJaWWfGrdUzln4rdARTP0AjroMpDJsKHY4ZzBWZ2ogUHvXhAzJthTRYWhEeLVX9YE1jySEXBDv7I/IJn500TR4eNe5nUophgbv4h8F3ma/J18wlis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774633103; c=relaxed/simple;
	bh=i4XRoGQ8ciAxF5LF/eeAmJpc/qwTn1D2VGvZGqV8ZKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XF+jaLrQj7tGJtdDBDDVfWXp3UZDn/c6yb4eQrMXVEvbmWNR6EHzq0fv4E8deu1uGXhc0v9OFoLz5lKbNZrAQTWvzu40+BOYUQyBU7MH/0fL8cvSeEqczJm108AwZzbyYiV/toKcJSD6nvarki9U3QP00K4ALDirA5PjKmWKiPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alhZHxPV; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-124a7216c9cso168435c88.0
        for <linux-pwm@vger.kernel.org>; Fri, 27 Mar 2026 10:38:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774633101; cv=none;
        d=google.com; s=arc-20240605;
        b=QE1cC50Z7YhJkkmwxHRCKlIg2plzM4YR+NJSlukYStw+QBrlEVYkvqQ4M6g43TVPGa
         oGaQRIWKTAez1pH4urm1RAxPXne+Yjy0j6OQucwpQziJIOvbqidgqZLo72364xSxAdte
         CJgfY8oftj5I0zlWIL/utsyU31KWeHxbVbyMlZkSYwjJp8XTthAaYqWAU4uRpbRqKUkf
         A7TIc/lOKwyvnPkNuZ8g8e4DN2se4q81YBU3nucQALW5P1soyKioe/iAs7pHpzDuOcfg
         K0Gixyg9OfTK/w9aPyV/WgoGjiLEL0OVZ3Ow+uzsiTjmd+d+BpGdbJRS3oprxP8mh3r8
         ibyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i4XRoGQ8ciAxF5LF/eeAmJpc/qwTn1D2VGvZGqV8ZKk=;
        fh=hv6/gmbY4/ZYGsh1G06ifiYVxpSRPtHKMccQwIYY3Bg=;
        b=ewK2KAKcPIGjf9U67IrEOXfFx2ZZUcRc+WR+nJacVaSgSNEoxNpFYy7zdXxvHqs9C7
         5dnC3zft7omguWv6NZ8WuD6OnPznh+n4+ysFGp4hOI8Rl9eqLhi9FMkEMgz/HkX6tRDP
         1nO7gyumU6qfxIvH6p7WAXsy/T1Cyr0VpnyTmErtGgSdtVr3wWB4zOUL565Ea8Er3F13
         a/RflgBhFb4w2+N+ZoNNcV879zeoNjRG4NP2CinDd6Fog0qGF41kYxF01vP60EtyGZS4
         uIF8c09egov5k9JFWrljyv2RHqDf90lOIjQVWYn8YjFPBDK79xTkYYARQIAxmw4E4bmP
         0XSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774633101; x=1775237901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4XRoGQ8ciAxF5LF/eeAmJpc/qwTn1D2VGvZGqV8ZKk=;
        b=alhZHxPV5T2fdatBwpj2qJAAxeRtPXJ0uDb7XsmPQMzRbOzf+FNggxXK/9ERofYKaK
         68wzUJeKMl2RQ3BFEWKdUeH5Wzxgn/AMCrYJxQ3WewbtyGNUN6dTgeyBHJz82XDf88xo
         tN8KKG+YkbO4pzVfiYFVJun/q5bwLGB4Xuhil81lq6s2QFGIXhlAVlbtRf4Yl2Jjibsa
         wHQKG6rSWGHIa/QrmPtAxDliATjiQ1K2nYH1s8wwMcZpFUFM3pQ1xyd1P3j5WvRikizy
         FOTR1/VE5V/jBwFY2NFUReT80NMyp9z/BNlvmscnh5SG2UmAtukhAaLB2orski9ATdtA
         SfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774633101; x=1775237901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i4XRoGQ8ciAxF5LF/eeAmJpc/qwTn1D2VGvZGqV8ZKk=;
        b=lZ+zl9ELlnkx+G7kUMv2m90NmbOAsViwouDD7umC0cg3t5Y1pSX67JUKeHPgbMqEP5
         4nCUYm1PnuTPm3HwCD/49zrs4ByVLCGLyzLstPaczHew4YrscE2sX+7xnEochQw6UmHn
         p/z6jVgsWFyXUa46JDLpdR60jQqU2x2O9MH3MapY8AVbDaxJUMfbctLrBvKE9jR5j8/Q
         0e0VPJt2Ub4fDroNdXLge7D6ML7G8r4o1j731thKAwHD3V3fiFf6Ntje+AmRpsWDSiTM
         DLZLaA9nNofzZQfqkoKQ2aAGFm1EE1CnweSi2AsBu2Y6aCMwl1ZmXiyQ0Wv9rjyWmzTF
         MmUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXf4L9Qp1A5KjnF2J/WeCK4wSpKepUJSaPIxX9Z7K5Y/Y7cvPfZ1tHe3TEr3kMIKUu4wMoUpC0yhK0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+llLlFQdNBaJNO7uWsWyPugil4Pl8sEjHpwiS+QbQku8RSTfS
	UjRLLQkDV8dJHf+zd/p3ahcvYSA2iUaZ260aV7itM6vL5bRPVyi+NCbqIFoHhUlCdzCCbKvgbT1
	YDfXefuYRbqkyqqrE1Jt/2fbMK4GquPQ=
X-Gm-Gg: ATEYQzyo/vCieTaBP6/meGoqPBakuwieuZpSxekEFhrgZ4Trrc3+gufkhKA3Deb3/v0
	tNZK3JbdWbi8esST3CAUiZ9JOdQFZzmqQFdoUepFI7DR6bHV2a3M+3mOZMURNoRb4aKKtffcEK1
	ApqBA9Kvhx0N6QIe222hfVB50Wv+RLOEr+z0tG3GSvGd/fDoqUkNdbU9TKGRXD8z7z+NgcTqfev
	IEWhfI9/cpTPOn3DbFgc8SN4RQsQhDanOIJlMqC6kghHOu9eEvAj1SiMw/P1L1842EXlP/HArF/
	XakVjd4Z5Dt1AGRxWm8RIxIxur9/rpJpcDlYOg24GZMfrR6VDbVspOxC6su6NuRekz/qk8dhTWY
	hjAc2iTq0vSw4a+diAYH6KSo=
X-Received: by 2002:a05:7300:3254:b0:2c0:fec3:fd2b with SMTP id
 5a478bee46e88-2c185f4195cmr868301eec.5.1774633101017; Fri, 27 Mar 2026
 10:38:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223-clk-send-sync-v5-0-181bf2f35652@google.com>
 <DH7L09UFWGTK.2MT0OTWH1DUV4@kernel.org> <20260321-awesome-hot-kingfisher-5d9f55@houat>
 <CABx5tqJvOFEzmadeXpDxSUjkghviqtP0jo+kzSB5X6u_P_j2ig@mail.gmail.com>
 <CABx5tqL+G9i1ZW7i5AHaTqUFTVRDmBvP=RycUdwjG-GOp4uzBA@mail.gmail.com>
 <CANiq72=M3H-06L7udG_LqTwLykZkAjfy2d5NXQZn5TYRJ+N37w@mail.gmail.com>
 <CABx5tq+TdGvL+SCUe87qWFgeAq-1Zf5w63jn2hLe9+YTyz4sNw@mail.gmail.com>
 <DHDOH1FXTIZT.1QKZIPZ73YNLI@kernel.org> <CABx5tqJho=k88A1L0neVeaiYCXpLsc7UjzGSgAug73ZC_amYag@mail.gmail.com>
In-Reply-To: <CABx5tqJho=k88A1L0neVeaiYCXpLsc7UjzGSgAug73ZC_amYag@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 27 Mar 2026 18:38:07 +0100
X-Gm-Features: AQROBzDgjWTAFVxg45-x5LUiec7rwVNiECYCnGtFbz1GIQ6qZ-C218NzMZcOD9c
Message-ID: <CANiq72=E=fyCjr_5zEoiUoSOYnXTzfFjE8KJRGsDeEQN1cFY=A@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Implement Send and Sync for clk
To: Brian Masney <bmasney@redhat.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Michael Turquette <mturquette@baylibre.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Drew Fustini <fustini@kernel.org>, 
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>, 
	linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-pwm@vger.kernel.org, Boqun Feng <boqun@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8397-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,baylibre.com,linux.intel.com,redhat.com,samsung.com,linaro.org,garyguo.net,protonmail.com,umich.edu,collabora.com,vger.kernel.org,lists.freedesktop.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5DBFA34887B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 5:54=E2=80=AFPM Brian Masney <bmasney@redhat.com> w=
rote:
>
> I mentioned to Stephen at the last LPC in Tokyo that I am interested
> in becoming a clk co-maintainer.

Thanks for the context, that sounds great -- more maintainers and
reviewers are needed in the kernel.

But, of course, it is up to Stephen.

Another possibility Stephen could perhaps like if he doesn't want a
co-maintainer for everything is having a sub-maintainer for the Rust
side, possibly in a sub-entry (e.g. "COMMON CLK FRAMEWORK [RUST]",
i.e. with the usual square brackets we use for that), assuming you are
interested in that.

It is an approach that we have seen works well, because it is usually
a win-win for maintainers that cannot commit time to review new Rust
stuff, i.e. they get more people in their subsystem, they can use the
opportunity to learn Rust (assuming they don't know it yet) and they
can assess how often Rust changes are needed, yet they still control
the changes (e.g. in cases a change on both sides needs to happen at
once).

[ In any case, I don't know the context behind all this -- if I can
help with anything, please let me know. ]

Thanks!

Cheers,
Miguel

