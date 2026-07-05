Return-Path: <linux-pwm+bounces-9557-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WQMPDZNMSmqOBAEAu9opvQ
	(envelope-from <linux-pwm+bounces-9557-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 05 Jul 2026 14:22:43 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A84B709F00
	for <lists+linux-pwm@lfdr.de>; Sun, 05 Jul 2026 14:22:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=QhyjfxyA;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9557-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9557-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 16DC730039BC
	for <lists+linux-pwm@lfdr.de>; Sun,  5 Jul 2026 12:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339C737E308;
	Sun,  5 Jul 2026 12:22:38 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D0C378D7F
	for <linux-pwm@vger.kernel.org>; Sun,  5 Jul 2026 12:22:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783254158; cv=pass; b=d/tZdoQDqWChW9Y9GN71AEzxL/FxMdEoE8ryc50tIvgbwJ0KbqD8hiK0rhx5zQ3OMsjyxnk+JzrSiOOfM9o9GEfiLfBEwmk0QLxHryccGEwW1gx9WShfpdwBtr+bssQIDsTN5GJgYyV5JmZ/ko1LvoLgOjCPb/YmU2vOizJ4CpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783254158; c=relaxed/simple;
	bh=cVZuwq26LJUbjnXW20W3nbICqbmkh5x02bCyytPFsmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=KknYbSY51wZQdYBoz0ypVhYTvphBiecfNn6xLWXeNrk2iauU3Z0kKAKDi4Etjua7lzzWk4kPrc6JM1awmxWpTj85E1nspo/1EoStJe72M/0yJ5pP+9UVF2nqrZ14+Y4QB+grKw7YQE7g13mpUkEccx5TCrlTF4/UmGvvwLzHGhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhyjfxyA; arc=pass smtp.client-ip=209.85.216.41
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-384422b05b5so192159a91.2
        for <linux-pwm@vger.kernel.org>; Sun, 05 Jul 2026 05:22:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783254156; cv=none;
        d=google.com; s=arc-20260327;
        b=fPnLSqchk0zflYzX27pelsyTUPsjOfxiHmV4dN+2uJnYcSQ+bW6rjeSgqUhGPMH3Dz
         dRadmzQHNWAd2Bio22QoynOLyx0RrGfnzgugclw2xXN1r8goNWz9fYp65Mkxs4RZOIcM
         FE4x7UyPwo2RSwlaoVEehjJKzmstjebE/Ur4R9GBbykcDIJpr/2iLwcQc0Gb0sAHKBgG
         c4NmPCHeNsD9xVXgD3fJoEkMGm4coKLOhmDhyxOV/lJ+XO3U63z+MjnShtbAjLRQ9o40
         6fqVOQVuBo31+CVab2YFQPCxYSqDUQcjNimPTTs2elev6IYJFb+4rD+8ww7nc9mVgamW
         4fMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cVZuwq26LJUbjnXW20W3nbICqbmkh5x02bCyytPFsmg=;
        fh=eUh3iqQQbhDzDbYKao2y5Uillfn8YxG6SXP5LMGdSQQ=;
        b=f/ZFw3hAoPfJd4slCTYNMzMceHl/YzWmqwbx5salpntFu56M6iY+mDkz4d6ElGM8zD
         QMVW/c91LYaQafCpxUkBKUPlQgBFEoBds6uIH1kRdQT2789lvO77dUUSNemA0UOBYj8r
         8Ih05wn/Dmz6YVujftCc7WsxNB8Bi5QafPlrwih8GW8Hu7cWKmBSZfIFWsK4IKCcs1IZ
         juyU9zOLa97vP7m9GdtkxEEroyJh0xQ2BCjDLnrjhK3vEnHwJvqW66ipWy2qfpCUxWQz
         haIp1TYIiRKmcbnH7xkj4M9wjVWRL0+97YKC+0EB8fCy4s9RSQwnHC3BC9+r5pHQ8HZK
         fWvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783254156; x=1783858956; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cVZuwq26LJUbjnXW20W3nbICqbmkh5x02bCyytPFsmg=;
        b=QhyjfxyATsOCVoQS1jHI7Mibm0pDUoc6hvz2g2DThUIjMUZJYAjaB/pjXj01gPkIvn
         PfUDF6VcZ+4vAS7mRO+8Tu3Lek9RvxtWQm6vEWu+ZDOW5AK4Z2AeTmPW7czcovGoyDq+
         ZVfrkt65J2lj7P8VTHHGIiyLDSOzsCql4fpQd+xA3DHo+FO0qg5BnVIv89TaShPzevFS
         Feej2fjYBtwo/K6so4aFuH7GfGlzqB/U/o8s3WKhvQfbIC106TCgOzeeVrhGV6CfgDRS
         fMD5LzSJzRbtv+Zn8VTyus83i47Pak+MLGzJSR5JcGngV0B0yK2vCcDoH0cgBqVjL5KU
         +I3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783254156; x=1783858956;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cVZuwq26LJUbjnXW20W3nbICqbmkh5x02bCyytPFsmg=;
        b=jvvDbFw7sjCIGHAV/hQEUiyffsqmXP/i5dAfiZ/fGdV5wNEKl5m4mskqz+5qXH5COF
         Yg8zFIUEzXQNyUONQRB5J8ot3BgfWyYyVT/hHnSzS1/IIXE3V/3adeYP9juuvx1QXd75
         b14GOV1GhkaxQppPcuTaThjiPm98V4/Qsj18IW4Kfc4csZt3KUXScp0mbCx5MMJbS3DL
         CCaX0uYatkHOio89EVxchK61dCwVbRNcK8CURPU8Xol1rlgMD+XnosIaqA77NDnyDhZH
         YbAQSpmpyyCLASjif2b00mC1BIRbg/uR+aZ8aYTz8592OBxEBbPCQuDRZkoMxdueFFwB
         8q3w==
X-Forwarded-Encrypted: i=1; AHgh+Rrbv69464wYw/K9yPAUO18wdr6EfKULs+ysX6Jr3Ky8rbOvz9l27BAMi3m1EG6AwSjTKTnopCk4nJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YycJn38CAOHpu7qG1qyPj77+8HZPPAseaAbmN9a9NynD7Db6TxQ
	auYcSHqu2nHz1RNEx81K755HEunh28i8ETw0ZXfn77RsMeDa+qe4aO1gRfE41xU+lk4Gn6xG7Ko
	7vJ3WS6zeW2jTpE7I68HxJ/1mF4QrUu8=
X-Gm-Gg: AfdE7ckC38Lx81AZnF8A6+kc3mcRKGuN1NWbHHRtE2+1lJHjofDqDs70vu1+JfCXPVP
	gN06smN18AkwQP7SavIyrBBLAp4uKg8i4FRZhmFm2AMRLY5ooJidP81PQgGPRuDhVj9SgLbxRde
	utEIkPSHrMRxjncN92jLrCVlTI8VB89KAzQKH6xc6CaSn+XC73eoE73/lZm4yHgjEy5MXvMJ4gd
	1YponnhCMxjax8Ab3rb4R5JHMAHOlcYSNL392o3Mzc5NHHCBemlGGWNfy9tvd7XIG4tOOWqvKC/
	EhfyA6zQDT1QNkXbW2Bykd9y1UtU3C7qsPdc0ktf8s+jB5/IUUrfB882CMWZ4hfasigLMnru7GF
	hvZzfiEwrkIYF
X-Received: by 2002:a17:90a:a416:b0:383:5a16:bd67 with SMTP id
 98e67ed59e1d1-3835a16bddcmr2702118a91.4.1783254156186; Sun, 05 Jul 2026
 05:22:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev>
 <c89a1bc8-6cc1-4e16-ac95-add389e45a2b@lunn.ch> <akmnh0AKFfu9-OYn@gurudas.dev>
In-Reply-To: <akmnh0AKFfu9-OYn@gurudas.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 5 Jul 2026 14:22:20 +0200
X-Gm-Features: AVVi8CdKZk1uQg3RyoO9gWWnGdg1D5rtqZ5BcTTqS2w4TtsLqn1TqMImL9QufHY
Message-ID: <CANiq72k0zokLC_L2wPJRDb_CyvnJznOSKUgTaiHo87GT6Pwyag@mail.gmail.com>
Subject: Re: [PATCH 0/7] rust: Use kernel style vertical imports in various drivers
To: Andrew Lunn <andrew@lunn.ch>, Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, 
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Robin Murphy <robin.murphy@arm.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Jens Axboe <axboe@kernel.dk>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, driver-core@lists.linux.dev, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:ojeda@kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dakr@kernel.org,m:abdiel.janulgue@gmail.com,m:daniel.almeida@collabora.com,m:robin.murphy@arm.com,m:a.hindborg@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:tamird@kernel.org,m:acourbot@nvidia.com,m:work@onurozkan.dev,m:fustini@kernel.org,m:guoren@kernel.org,m:wefu@redhat.com,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:rafael@kernel.org,m:viresh.kumar@linaro.org,m:axboe@kernel.dk,m:fujita.tomonori@gmail.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:driver-core@lists.linux.dev,m:linux-riscv@lists.infradead.org,m:linux-pwm@vger.kernel.org,m:linux-pm@vger.kernel.org,m:linux-block@vger.kernel.org,m:netdev@vger.kernel.org,m:nova-gpu@lists.
 linux.dev,m:dri-devel@lists.freedesktop.org,m:abdieljanulgue@gmail.com,m:fujitatomonori@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lunn.ch,kernel.org,vger.kernel.org,gmail.com,collabora.com,arm.com,garyguo.net,protonmail.com,google.com,umich.edu,nvidia.com,onurozkan.dev,redhat.com,samsung.com,linaro.org,kernel.dk,armlinux.org.uk,davemloft.net,ffwll.ch,lists.linux.dev,lists.infradead.org,lists.freedesktop.org];
	FORGED_SENDER(0.00)[miguelojedasandonis@gmail.com,linux-pwm@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[43];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9557-lists,linux-pwm=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gurudas.dev:email,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A84B709F00

On Sun, Jul 5, 2026 at 2:38=E2=80=AFAM Guru Das Srinagesh <linux@gurudas.de=
v> wrote:
>
> Miguel, could you please indicate if you have a preference here?

Gary is right -- it depends.

Generally speaking, it is best to do changes through each tree;
especially so if it is the kind of thing that may be prone to
conflicts.

In certain cases, yes, I may take treewide changes, with Acked-by's
from maintainers (and very exceptionally I have done it without that
if e.g. it is trivial enough and enough time has passed -- trusting
that people trust me to do so).

It is part of why the Rust tree exists, i.e. as a fallback and also
for convenience in certain cases.

I hope that clarifies.

Cheers,
Miguel

