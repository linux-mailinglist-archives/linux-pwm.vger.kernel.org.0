Return-Path: <linux-pwm+bounces-8391-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLqYCEmcxmnrMQUAu9opvQ
	(envelope-from <linux-pwm+bounces-8391-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Mar 2026 16:03:37 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B2A346703
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Mar 2026 16:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A565304C954
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Mar 2026 15:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DAA1C2324;
	Fri, 27 Mar 2026 15:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/AIeTGJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC58175A5
	for <linux-pwm@vger.kernel.org>; Fri, 27 Mar 2026 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774623632; cv=pass; b=ugM+oJi6Dg6utfgIvClji8ODclswtxW4RcU5PRyU6DYTFCEKQ2ab0PhPpy3wfPD+IS1jtJ/1nzMyJ2V+VoW3Kqt+zkxXne5FDgJqNr2rYJbR8RrXpCDWE3oLF/kepUjO5ujM6Fga/JjPwV6dJjpPZwMN2sGy+LBbm6E7zAVP7gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774623632; c=relaxed/simple;
	bh=D9xCXX4qh7yDgqFtjupRac54WTmWuupUUXzjqiuoTv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aFahCuQ6MH6jnV6z3Apz68bdSykoGm2zVJynOMPQgDHn3aSwQbSQW6qyc+lNtxx5loeS5ppfg0qj8W36Otthd8oI9pbB+SN4KCadCwIVEa5b8Ck7d4RkkL4qpgLFMdESgrmZcrJa5yi0nslTjt5nAu0d2BcQB9jOlTR6XI3kcDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/AIeTGJ; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12a6b260693so298054c88.2
        for <linux-pwm@vger.kernel.org>; Fri, 27 Mar 2026 08:00:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774623631; cv=none;
        d=google.com; s=arc-20240605;
        b=BC6EicceYRV5QTJL8LoF3rds22HmJU+5Gen3zgXMfmsz9m2EUnlmmQBU57wvRjq2bU
         jPzk+ICGT5K/f0O8Xps+I4dZhlDr/reF8j3kEFnZugsGArPG2Hp2E4C0w5cPs8b9rU35
         0wgz5jVSbypKQLKzSHYB7toaQiB0VntH6uh6bQRUbnnjJTLIjjFdy+EPn9f+jeJHXxrX
         a4/9wqodsXCnE94XBmwP9ZwR0F960qiu0hdjJRQfwixiW3aIpbrPadRwDl8Hn06+9uPS
         49w+OFU0JXLO6ekYO+3N7gWTRkMWkqcjxMGXtA25RH5VyduatzeYnaO+QOajYzpSFF8o
         UdNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D9xCXX4qh7yDgqFtjupRac54WTmWuupUUXzjqiuoTv0=;
        fh=+zA8C1sshlN+b8/fbSOTV8AV58WU+C1yIMu9cFNa1AQ=;
        b=Pql9chG/TQ29LNqVcjHXurv8wY8c14xwNn5pFn8EXaEzRdq7qBpTk/7eSt+WiRiK2+
         UwZB0sTPetjS0ey/K9mlX2zDIYCLzLeTa38yBpFxKx+CnAzGuT7e5SlZrU4l2uN5dF6u
         uAQStagd4sBgEV+WxUtxAkwfYra/VzVrQkmwJaNwC9ANE6Bkrs8NN5s+cULiaGcDeCDS
         fwJZ+WJZd26MLZZXODsAZuuTYhLnpoEL5VMLkXw2ybvgROE+cLdH1edawEebCdLvf8Q1
         Zya7aQ+5Sh43sZy5zD76Rmpx9MsB5iCFqqwWgGC+Su2j2JXsAYFlrSkYNVefTB7HokUg
         ZfRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774623631; x=1775228431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9xCXX4qh7yDgqFtjupRac54WTmWuupUUXzjqiuoTv0=;
        b=V/AIeTGJtPpwVUdsxrEOZw9ZJI4hUZZQ4n6eL+dQ7Hs7SZSN+IqHQYZvBddYnfShbH
         KCb+bttTBwWh0wjcz9wQ2bSwdtSqu1AhhIhvCcroEHSuiRUNMI08xwLal/Et9ndp59CZ
         foaAHr+cmB51VcgaJni5jyrOSyk26PDNW6VZwQHVUBBXdod862bmiXHQMq5CRFzAI30e
         812YtBpWJ/9bjWqPAeEOWIUoh8PigQ8NgygTznymAnahh2+r4iGi0pIJNrM/5PZ6E/h/
         1BX9GrEDOm2rDM9X+PzQCowF0wT0uHXRpAE8bPfy/bkULcdkmmSgxyZ0Um7JfUD3KW0Z
         DxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774623631; x=1775228431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D9xCXX4qh7yDgqFtjupRac54WTmWuupUUXzjqiuoTv0=;
        b=Yz6n8/NqXx5Js50iXp01qRMmsedWZfok7AHGsI8aQGPwPE2ULDlfxp+I7/rab+D1cL
         v72OaZJPjS4O/rEe2Fo4koNFQm2q8WIsB4vEdEZIa4NIEa28DyV2yDKtFIXmkIvp87QK
         QFJSaVWDBbfkf/zc/379ao+y4PkDJILgx7Uz1cH4TE2adM6XjjF6otzqHPW74v7D1Ga+
         gpCcC2ZBW9ToChRN2i+L7aHD0JtMNl0sNUcRfwUupiqb16RX3pXXJdS8LTXTTFE9TaOJ
         aRtm88WY5LpW+E94P7jtfG5dY4QpRfWLzkZ1vAkrZ11E9EhI/jn3bEWYzHzGZ8OfPYSC
         l1xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVobogxA/+T/qBH1Sh5ebjpAqlQqzpkvam07IfSw3BKZNrhBDc3PKj6Lo2VlnvgwXgwatn7ivkMXe4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg2FxSlnyzizzQkKyObZ7sh02zrpv0xx0j5YS2qM0+vK7wAeRz
	j4xd8/U6yx5fAlJor5227GA1qO9nvbDkzEKTmxG7YpN52EWfQfXqIbFw2igcYllclvMPDBvl1s1
	u8gNI+eJeJJii7VA/JLZgbkOQ2jW5TQ0=
X-Gm-Gg: ATEYQzxY2lmFbd3zyUAosYnjQB/Nt52yEU0CzGXtvzHpJK15J8KK4QISj6F479ohkh4
	gWh+1CrjRrS58IDE+TCMf2tRYs9MJ6bz7zdcki4FSDdNs+fJ3e7WrQrULII3hTMZcB2FRgkq371
	ETq5RHWjOlHchhSV3dVbfKZ9n9ZDfcT3SLV8JrEr+RK/4cny/gsCPBiyU6lZG15htMm1Er+z+jc
	z6pRCQCDhnQ1qJtgIjB5WMXAav8vr+obU6uKq/yYbMWKjrG9K3QmVy8fU9RtSiPRbQBQlbHY3Hk
	eEF1rvgAbwaZuhA+MzKKddO8D3fCyXPckWNvEhYCajaiTOWfaavj/WedxOhlUtlbHfmFMqedYiH
	jY2MPStKIWVaOHyc4TYOIRgk=
X-Received: by 2002:a05:7300:3254:b0:2be:1946:858b with SMTP id
 5a478bee46e88-2c185e6b478mr676695eec.3.1774623630624; Fri, 27 Mar 2026
 08:00:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223-clk-send-sync-v5-0-181bf2f35652@google.com>
 <DH7L09UFWGTK.2MT0OTWH1DUV4@kernel.org> <20260321-awesome-hot-kingfisher-5d9f55@houat>
 <CABx5tqJvOFEzmadeXpDxSUjkghviqtP0jo+kzSB5X6u_P_j2ig@mail.gmail.com> <CABx5tqL+G9i1ZW7i5AHaTqUFTVRDmBvP=RycUdwjG-GOp4uzBA@mail.gmail.com>
In-Reply-To: <CABx5tqL+G9i1ZW7i5AHaTqUFTVRDmBvP=RycUdwjG-GOp4uzBA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 27 Mar 2026 16:00:17 +0100
X-Gm-Features: AQROBzCg8z5hsjJLNQncsQnLe5Jv3qMm0sXMulY5sLScvTl8_VvaOlFJW_RT3vc
Message-ID: <CANiq72=M3H-06L7udG_LqTwLykZkAjfy2d5NXQZn5TYRJ+N37w@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Implement Send and Sync for clk
To: Brian Masney <bmasney@redhat.com>
Cc: Maxime Ripard <mripard@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
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
	TAGGED_FROM(0.00)[bounces-8391-lists,linux-pwm=lfdr.de];
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
X-Rspamd-Queue-Id: 88B2A346703
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 2:19=E2=80=AFPM Brian Masney <bmasney@redhat.com> w=
rote:
>
> Stephen came on the list and started to merge this things this week. I
> was going to collect up more patches for him if he wasn't around, and
> intended to include this. However, since he's starting to collect
> things, I'm not going to send him a clk pull today.
>
> It's up to you if you want to send this in via drm-rust or wait for Steph=
en.

I guess it depends if he plans to pick it up this cycle or not.

If he doesn't, then it may be best to just go forward with your
Acked-bys -- Danilo can pick it up if DRM needs it in their branch,
otherwise I can pick it up.

Thanks!

Cheers,
Miguel

