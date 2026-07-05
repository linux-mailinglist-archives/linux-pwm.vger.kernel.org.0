Return-Path: <linux-pwm+bounces-9552-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q43hLRKtSWor6AAAu9opvQ
	(envelope-from <linux-pwm+bounces-9552-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 05 Jul 2026 03:02:10 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F250A708BB5
	for <lists+linux-pwm@lfdr.de>; Sun, 05 Jul 2026 03:02:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gurudas.dev header.s=spacemail header.b=gxzDANV1;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9552-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9552-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B972300BD9F
	for <lists+linux-pwm@lfdr.de>; Sun,  5 Jul 2026 01:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334591E633C;
	Sun,  5 Jul 2026 01:02:08 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from out-06.smtp.spacemail.com (out-06.smtp.spacemail.com [66.29.159.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D170C4207A;
	Sun,  5 Jul 2026 01:02:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783213328; cv=none; b=KWeoYsODK9a0kyomA9oA7JvyYBc5V0T8gd/2OlrWIXCwAcSfqoe7ptjmCBrxSs77VzZDF7Q85mEwJ6iEZKI64pTHgxHmBmstvgZgFORnS02345l7JTKmq0zjCIMFode3kw7TSp82s5jCi+nCgWjntyGPyglMvleK8OYHQX6BjKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783213328; c=relaxed/simple;
	bh=P3lugvHk1nwzrdTe7G8u/RXPAFOq2rNX03Ue4yK1EdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyHFNZfemT/vlp3PLJxCrq+DQZuBicHD6aMh1rONrw0Ltk11SDTmU9SBFrcelcPKOwcNVGldyXBq6rypQr1V4Dx8BmRyTHYFqOtUBFXs7zPVx59vt6YqcrA9YYmruP3P4B97tmWG8SJUIC8EinZNej5M42+7Eieim2P0J8l5WAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev; spf=pass smtp.mailfrom=gurudas.dev; dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b=gxzDANV1; arc=none smtp.client-ip=66.29.159.77
Received: from gurudas.dev (107-194-158-19.lightspeed.sntcca.sbcglobal.net [107.194.158.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4gt8Mn0CXjz6tkM;
	Sun, 05 Jul 2026 01:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gurudas.dev;
	s=spacemail; t=1783213318;
	bh=2qJqLI5cYmY6XssOjT5mS6RQt8tME0zYaMT/RBuKHhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gxzDANV1JQoWbSrlTIw2Hbb83lUzmrjW19c3OZvI3lIFLUx0NWjORGAdcrfZ4Iy1r
	 8iyC/nftZCN6RsgyVPXhGqT3xB7lKhDTIYvv4mPgt23HneL2vlZdPZGvj5/AKk5Pfp
	 wZfKzZkjQvogs3VONlJW1oADetqYF+Z1IsjAZyW86GXa/ntxYiqBXIBTcI8TBWs5qC
	 6LphD9AsDF1QQyi7SDc//YsSj4N4PrmToDXekNK0bsPhGwCiGJIgQfdhGPqBLM/i3q
	 aiuUXbswiQh086BPfvu9FQvRyd8BtJCb/XDmrMZaTKsgOjTHbYsMvyE/xBsne6r0RG
	 gHli7e1+IvGdA==
Date: Sat, 4 Jul 2026 18:01:55 -0700
From: Guru Das Srinagesh <linux@gurudas.dev>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Jens Axboe <axboe@kernel.dk>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	driver-core@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-block@vger.kernel.org, netdev@vger.kernel.org,
	nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 3/7] cpufreq: rcpufreq_dt: use vertical import style
Message-ID: <akmtA7EbVBdhRAOq@gurudas.dev>
Mail-Followup-To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Jens Axboe <axboe@kernel.dk>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	driver-core@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-block@vger.kernel.org, netdev@vger.kernel.org,
	nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
References: <20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev>
 <20260628-b4-rust-vertical-imports-v1-3-98bc71d4810b@gurudas.dev>
 <f0ed588a-6cfb-4079-a2fe-7c14f1b42727@oss.qualcomm.com>
 <CANiq72=SQK7pd-fj+4MOb=E6=R-DHCcLcuCvN=us2E5o7Rcy2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=SQK7pd-fj+4MOb=E6=R-DHCcLcuCvN=us2E5o7Rcy2A@mail.gmail.com>
X-Envelope-From: linux@gurudas.dev
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[gurudas.dev:s=spacemail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:miguel.ojeda.sandonis@gmail.com,m:zhongqiu.han@oss.qualcomm.com,m:ojeda@kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dakr@kernel.org,m:abdiel.janulgue@gmail.com,m:daniel.almeida@collabora.com,m:robin.murphy@arm.com,m:a.hindborg@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:tamird@kernel.org,m:acourbot@nvidia.com,m:work@onurozkan.dev,m:fustini@kernel.org,m:guoren@kernel.org,m:wefu@redhat.com,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:rafael@kernel.org,m:viresh.kumar@linaro.org,m:axboe@kernel.dk,m:fujita.tomonori@gmail.com,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:driver-core@lists.linux.dev,m:linux-riscv@lists.infradead.org,m:linux-pwm@vger.kernel.org,m:linux-pm@vger.kernel.org,m:linu
 x-block@vger.kernel.org,m:netdev@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:miguelojedasandonis@gmail.com,m:abdieljanulgue@gmail.com,m:fujitatomonori@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[gurudas.dev];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[linux@gurudas.dev,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[45];
	TAGGED_FROM(0.00)[bounces-9552-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gurudas.dev:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@gurudas.dev,linux-pwm@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,vger.kernel.org,gmail.com,collabora.com,arm.com,garyguo.net,protonmail.com,google.com,umich.edu,nvidia.com,onurozkan.dev,redhat.com,samsung.com,linaro.org,kernel.dk,lunn.ch,armlinux.org.uk,davemloft.net,ffwll.ch,lists.linux.dev,lists.infradead.org,lists.freedesktop.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gurudas.dev:from_mime,gurudas.dev:dkim,gurudas.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F250A708BB5

On Tue, Jun 30, 2026 at 10:35:00AM +0200, Miguel Ojeda wrote:
> On Mon, Jun 29, 2026 at 2:43 PM Zhongqiu Han
> <zhongqiu.han@oss.qualcomm.com> wrote:
> >
> > If the preferred style is to place each imported item on its own line,
> > shouldn't imports such as
> >
> >      cpu, cpufreq,
> >
> > be formatted similarly as well?
> 
> Indeed, good eyes.
> 
> To do what we want, `rustfmt` needs the `//` at the end of that level
> too (in the future, it will be without the `//`), i.e. the patch
> probably passes `rustfmtcheck`, but it still needs to split that line
> and add the other `//`.

Hi Zhongqiu, Miguel:

Yes, I did run `make LLVM=1 rustfmtcheck` and it passed on this series. I will fix
the missed ones in v2.

While investigating this, I found that that adding this config `imports_layout =
"Vertical"` to the rustfmt options would fix all the imports automatically, including
the ones I missed. I ran it locally on the files touched in this series using rustfmt
nightly and it correctly fixed the imports as desired:

    rustup run nightly rustfmt --unstable-features \
      --config "imports_layout=Vertical" \
      --config-path .rustfmt.toml <file>

But unfortunately, since `imports_layout` is an unstable option currently [1], it
cannot be used straightaway.

However, .rustfmt.toml already has a section of commented-out unstable options kept
as a reference for when they stabilize. Would it make sense to add `#imports_layout =
"Vertical"` there? If so, I can include it in v2.

[1]: https://github.com/rust-lang/rustfmt/issues/3361

