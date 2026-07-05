Return-Path: <linux-pwm+bounces-9556-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ib48E1FKSmoyBAEAu9opvQ
	(envelope-from <linux-pwm+bounces-9556-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 05 Jul 2026 14:13:05 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 988EC709EB8
	for <lists+linux-pwm@lfdr.de>; Sun, 05 Jul 2026 14:13:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=EiS8dlOM;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9556-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9556-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 424DA300C587
	for <lists+linux-pwm@lfdr.de>; Sun,  5 Jul 2026 12:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10E737DAAC;
	Sun,  5 Jul 2026 12:13:01 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3981A36C0AB
	for <linux-pwm@vger.kernel.org>; Sun,  5 Jul 2026 12:13:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783253581; cv=pass; b=FU7xB2dehOJifGT8ZuzqLVLS6RaO6fqI8BNwuEBOjCjJILNqEWwMqH0W2ryjIqO2+Mmn+7L1RANEqc1yctczllhIWrAJKYFMKAGFD3ILUbKTWeX5h2DFQli1Q/1ZgH0dwfJLMVewe5DytCDCEqhu2GiniL7n+2eXa2C6++7X3YY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783253581; c=relaxed/simple;
	bh=5ISwFpI0UbPRq9FTX8wSAZ5/fVWcYX66lDYusFmfZZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=pYMPBTFSXqRCbMBEgTt/FbD6Ogb1Oncw26xaZAq/2Y9U5OG0Lebrux8jbAV0FH7ZWV3/fF6GiKgvUz4CfnWStlQEG1gmPVToFrVrehgvvEZ1pSQ3eTLxAJML+frFv603QibhpwhCyTIpwZB0ziqXHQpYo+Y+fi03XA5XHaGxxt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EiS8dlOM; arc=pass smtp.client-ip=209.85.214.176
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c988e16bb3so5122105ad.0
        for <linux-pwm@vger.kernel.org>; Sun, 05 Jul 2026 05:13:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783253579; cv=none;
        d=google.com; s=arc-20260327;
        b=HAMOpmbBdmnWCUVOR/Ykx12YaPgdEAJX/Gq092SuPJtexln8yTJpWIue0+/oyRBrJX
         gvkSWVOw5qOfZdDvTjWwCx5SPzBT9U1ysRa7QDvmRDxBO5DuVRDAi5q65TyHJMmr806f
         BolcF8Itimq+/JkPtW2WfrIPLTZO7JLE0S24LoKs8E71tUihvYxWWSwE4RBNissDKbbD
         sgfWPbaSKpBNaC8ubxXe9IzJXIl6p8yv59rxLM9UIl9SEA825bZfBAV0bgdJPGkQeLwt
         xzChYbFko6WmvuL4zBH5sIAd84BPMsOLH6vylSA/8QQMd7Lzrj9VC++qfcy/q7WP6RNw
         klRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U0wpLikbkQ+TMe9JGtyw25kNkY3ZEdsCI94B3LxA6AA=;
        fh=ZeZPdt2KphfsMBN3Ebn5zMllfM2aV0b9d/q1F+4PZ+E=;
        b=gQDEC3hyDwNXjrt60y3bdn9ugcjX+YrfsqyDqUfyhwqR6EbUImoXnquVqi8NnM4k0w
         pbW/Qo0sVFjXjvncKD4k4guwmRgk0pjB/e5XO8pkCaHnLeen9KvBNMRy0xt2EuO9DLn9
         MdBUPaI94V/byOzzWLucUQNqLeHIFxmVp45Yi21Eo0Wbq2LTbr5vBftOL2nrkTAbe/uA
         +UdK5lnBy2iaUp/5JjHkCL72Bt2OtCBUret4//GvgRcxrRUm3U8NQht9lZdH5XmlKcTC
         vSxw3/sEJsuW5MokIBn2s+LxPhKdA6nJRUj5gTUbpynoB+OzX1RMBMYDUH0DDILpx7Q9
         FCWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783253579; x=1783858379; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U0wpLikbkQ+TMe9JGtyw25kNkY3ZEdsCI94B3LxA6AA=;
        b=EiS8dlOM4eyK6m1HpW3B/2Lk4Ke8vaKmQ1grSKFAJWT3nDgHQp9PHG6jDFJWFMvvPG
         oCku+2dl+HfLBkdKZgSuHLUA7YZqNbbMrZm2TVKZv4KZ45li1mzTsRsicFKWdCN+v+zi
         IdwL4gSU3xdcrd7mNZoZYzHVr3F5FCVUfsFcww01QxO2XIg11BR+z3vKVvWkHs0gbj5I
         2DZJKv0/WQyEQ8Ha6Xu82TGTSYANNStIKhMU5St9tH4npH0B5hAWmCb/g9/YoriaRJzj
         b431tZuxGVTTDaog+QabLoyvZpxKg8nku7BLjtK1/CPlyoToF4FA0vaITOaO05iHBIt5
         lnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783253579; x=1783858379;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U0wpLikbkQ+TMe9JGtyw25kNkY3ZEdsCI94B3LxA6AA=;
        b=WBkwZ3iy2ro9EMeQ33nsc9jq+YCCio2uAWZo5YkYW8A9dMkiPiReVCj01ackY2Zvrw
         pJfIFM0ozXjSqSKGOjF7iQ5SkM0aJTistnIrLAPCdY23IlkqcRuZTQ7CvxMn/ea5whJx
         g45SRo3K8ydudZgHyOvOzyVb6vuC/7wu5IO9ViuT45fPKqLw1S74yzVT+6UmgFGlnwVW
         AJZLE5+wOD/ynFJbPQNPqc//xBNDBQEMjcpUMnFiFFWD2dQ+DCzd7qegfP9owv2sUUcD
         ZzBazqmpz5Bxa+oWfWeLHIVxtt2+m2C73Z/sY+q8qi1Ta9kIa0T85R5cr48Wj0KaKOrs
         c0Wg==
X-Forwarded-Encrypted: i=1; AHgh+RrKaRjmgJa2x3XotBk3PGlnG9wdiZGI4bvbNAKA95nAFuUwoFqHG9GJfi8BX2ZtxkLUBZ2+j53ci08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3enNeWIAjpWcpHYggcXBUTUkI6Z+xNU8/ITkaO+8Kj9oCgGOR
	Hf5pNueFSYcpy1qRo/qI4PHqWptwCqb3StG/mSb9c0P9qyf1BQCllkz2jT0y9My/dWJbBLBRYpw
	aZXK+xAc24T/qWFHxlrhvIxJE6rTJaAs=
X-Gm-Gg: AfdE7cmvLAJfOvB2PqZVV5d7DtLYg6tTpac7xCrpugZQeJDFYEqfU0M5hoFEPw82PNP
	7yUfiTp6/Mqtg76lBYxB0ASgftsR7KlRk/2vq4kL7W4dG/r8w0PPLPBSqCVj1/AIWXFiHfXxau/
	sFifKK8vztGDv44VtlVzMk99QA/8bHweRqq3kltbGBY5TeUNVgMKAb9Zk6nxM/J+uUKtFmjTw13
	/4aikFz1nz6Kv2jhrxTSXLg5Y4PImyQpp6eNRfLEDga7UXPm2HHKO8UrBiswntbZPG9PBQGpj1f
	OirQyDin78Wal2CDGbJ8PIW8Y7Bl4xXF/855rs72Fq6otxQYkZPzwPCS2l8REet8Eu/6SlR3r2f
	GWvn5EKar+q8K
X-Received: by 2002:a17:90b:268f:b0:381:28e0:6248 with SMTP id
 98e67ed59e1d1-382802beaa9mr4128789a91.1.1783253579563; Sun, 05 Jul 2026
 05:12:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev>
 <20260628-b4-rust-vertical-imports-v1-3-98bc71d4810b@gurudas.dev>
 <f0ed588a-6cfb-4079-a2fe-7c14f1b42727@oss.qualcomm.com> <CANiq72=SQK7pd-fj+4MOb=E6=R-DHCcLcuCvN=us2E5o7Rcy2A@mail.gmail.com>
 <akmtA7EbVBdhRAOq@gurudas.dev>
In-Reply-To: <akmtA7EbVBdhRAOq@gurudas.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 5 Jul 2026 14:12:47 +0200
X-Gm-Features: AVVi8Cfl7DMeNQYuJP9tYThrU-TabLAul_khYoWVx5WCyAQG55ujZm7jKpKar4U
Message-ID: <CANiq72nESZyX95XSKC3zaog=XSQF09bYJmre0mUbtQ42-Ly6tA@mail.gmail.com>
Subject: Re: [PATCH 3/7] cpufreq: rcpufreq_dt: use vertical import style
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Miguel Ojeda <ojeda@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Jens Axboe <axboe@kernel.dk>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, driver-core@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-block@vger.kernel.org, netdev@vger.kernel.org, 
	nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:miguel.ojeda.sandonis@gmail.com,m:zhongqiu.han@oss.qualcomm.com,m:ojeda@kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dakr@kernel.org,m:abdiel.janulgue@gmail.com,m:daniel.almeida@collabora.com,m:robin.murphy@arm.com,m:a.hindborg@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:tamird@kernel.org,m:acourbot@nvidia.com,m:work@onurozkan.dev,m:fustini@kernel.org,m:guoren@kernel.org,m:wefu@redhat.com,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:rafael@kernel.org,m:viresh.kumar@linaro.org,m:axboe@kernel.dk,m:fujita.tomonori@gmail.com,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:driver-core@lists.linux.dev,m:linux-riscv@lists.infradead.org,m:linux-pwm@vger.kernel.org,m:linux-pm@vger.kernel.org,m:linu
 x-block@vger.kernel.org,m:netdev@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:miguelojedasandonis@gmail.com,m:abdieljanulgue@gmail.com,m:fujitatomonori@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,oss.qualcomm.com,kernel.org,vger.kernel.org,collabora.com,arm.com,garyguo.net,protonmail.com,google.com,umich.edu,nvidia.com,onurozkan.dev,redhat.com,samsung.com,linaro.org,kernel.dk,lunn.ch,armlinux.org.uk,davemloft.net,ffwll.ch,lists.linux.dev,lists.infradead.org,lists.freedesktop.org];
	FORGED_SENDER(0.00)[miguelojedasandonis@gmail.com,linux-pwm@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[45];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9556-lists,linux-pwm=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gurudas.dev:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 988EC709EB8

On Sun, Jul 5, 2026 at 3:02=E2=80=AFAM Guru Das Srinagesh <linux@gurudas.de=
v> wrote:
>
> But unfortunately, since `imports_layout` is an unstable option currently=
 [1], it
> cannot be used straightaway.

Yeah, we are trying to get that one stabilized -- upstream `rustfmt`
is aware and working on it. More context at:

  https://github.com/rust-lang/rustfmt/issues/6829
  https://github.com/Rust-for-Linux/linux/issues/398

> However, .rustfmt.toml already has a section of commented-out unstable op=
tions kept
> as a reference for when they stabilize. Would it make sense to add `#impo=
rts_layout =3D
> "Vertical"` there? If so, I can include it in v2.

That may be a bit confusing, because we still need to add the `//`
comments. And if you add them, then `rustfmt` will format properly,
i.e. you don't need the unstable option.

Put another way: the intended workflow is to add the `//` and then to
run `make ... rustfmt`.

I hope that clarifies!

Cheers,
Miguel

