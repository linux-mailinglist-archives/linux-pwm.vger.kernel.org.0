Return-Path: <linux-pwm+bounces-8105-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKtlF8KhiWlU/wQAu9opvQ
	(envelope-from <linux-pwm+bounces-8105-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 09 Feb 2026 09:58:42 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDDD10D492
	for <lists+linux-pwm@lfdr.de>; Mon, 09 Feb 2026 09:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7707930041E9
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Feb 2026 08:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A96326947;
	Mon,  9 Feb 2026 08:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NhiJO4jS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B45326943
	for <linux-pwm@vger.kernel.org>; Mon,  9 Feb 2026 08:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770627519; cv=pass; b=oOW4PQrTEajMwL0MSyKnWtCbaed5TNtn8v68nOzUoH9jyQYGJtqbllQI6YGK2XvFytgO5Cd35+zPBUQnt9PjND/gJ7JaMAMiY0sg0ApO9Md7Oem/ZmVPbZIAw3PD0nUVYFh+llUGdaysE9M58guZceRvAzvcwvsS/OjlpORUbkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770627519; c=relaxed/simple;
	bh=sZF8QioVPx66S52+o1qVUemA5DYc+9Uk6M8KZF1VQAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TdaZl8us2mPNcZYPvKuiTjY1xeBfXr2QxABcmTkGIHgT+igte2OTrXMKZb86W6ajWY6V4Gd2Nm7lFdJcHaZLMzNaskLTbcl8z352Z2yuk+ZQHkiHI4oti+fKJKGU6B/biswUFtVZD2Wg5BcbXBrbx/b7oDrhwAmSw2lsSh+bChw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NhiJO4jS; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43284ed32a0so2774381f8f.3
        for <linux-pwm@vger.kernel.org>; Mon, 09 Feb 2026 00:58:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770627518; cv=none;
        d=google.com; s=arc-20240605;
        b=QcWi7hzIF0rc8r3Uys3Iqci1u2qF4H1zsEJrXbEWQLNWLJOaWuqG5El3uMjWRRXT1u
         0ibRCuxUR94CoosE0HRzF68e1/d8iARRyYZwy2d0mffGl7XYwRTEomk1Gl443WDu6aVP
         OQoI++eCpVYVWlOmO6TRUpv4TSFj2lA4FhCyABWSzP7ZjKkz1+XJQkr0EZk+oOoDyz/b
         Y7RqgTBWw8dXK4e6ltttUQH+g9Q1kRZ/E1FawvnF41NROOnPzGd0uNqBCgvq4WSUsCFw
         2gUNqNQF3AYIYb2aDu74z5bg7Zp55OVMyqJ3Xh2eQpRYuroCpK4adEyNV47qHXEsA+3X
         iIYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ep1Ke8qT73X8duJEqzvT5xFlLYeklNidWaAFB1OordM=;
        fh=ZjXWzU9T4YClI27qwQz0zJVzAUErPCWclIq1kUpsvzU=;
        b=YovAGfQIxAGPCjLo8XtRtz7KkYHBdP9A/9dFBpEEUSVpDjE000SGJsrWkTSjJETyov
         i3p51DHET0tUlGnF7ZJY3CiP5hw/EiRqqBrzglWFPUEqS95ybxmOk/Q8EgYxK4uwSFqZ
         CRe8+ZqsLu38CciQ3RM/rIz/U+vr38p4JA8hcbSAfS7A7xGS7SO5S5Z/vL5ghRcB4er4
         LHpEXwbTE3e9AH5aGaR8s3US3tpQda+jJZ1fOe/Z5i1oAcrILOrmLugnTP5MVYnjF5ft
         rKVpbiD70pgknQxyJTOtv5hJS8IKVPf4DRL/ILGgOdgFOJGkftApDyc1eqMq4HHvnE0e
         6YeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770627518; x=1771232318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ep1Ke8qT73X8duJEqzvT5xFlLYeklNidWaAFB1OordM=;
        b=NhiJO4jSywbvNigbjXvWXF7o2yVlEKcYX3sHTf29i0QcjC57wYSAePLgnuStTfwDLU
         o2RUpD/VeHB+A1ZwY2Rexs1FulVKuUwTjcQ/6MdP+xqdWgHd8BFEiQXBmFJBwwxeA0/Q
         ns//tRa0qUSsy4drXsY/d1pSwB+z7Tt4/06FsjZSYXluueZfjNnvvLCoDi82KU7VRYr+
         6Kwou991CH1mNJa7NHCHXJLHtVWkfcdKZQMtOhQXU6I9VCP7O8bm+ACY9FyLk0DQdJOo
         fID0N3g+22rWlWFNH/6FKPJdB+N5flWCMz9a9V72HZAuZG0ghju/G8Fw1v1t1++sWNVP
         q9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770627518; x=1771232318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ep1Ke8qT73X8duJEqzvT5xFlLYeklNidWaAFB1OordM=;
        b=w8Hpaaptp2Hr567iTl6bAhnA7iB3VZVpviEjc50CfAmsrUQWtDcvg3GLUyTiYUbcAQ
         q0K09CZeG+FWRDxJtxVJVvH4wAkLnMYHyuZssmsIVu+gTQiRKw/hGrEzLFSjhk1JF4C2
         fqMjbFW+psYT7KVn6D884+1BYaxr8KlN3wVByuvMHCul2MygQJgbVVSiBjY80NjNJh56
         SoDjNiufaqwfxlylPGE/CV6Ogfrc694r4vShyabY8yimHIdbj2NWz6h5zISzvh/7mWuU
         LqQ158TOVv0XARw/bA8F/vD0XtevXSWsBr8YmGGsdUlruoWPTXWp4dci+oyK4xmoYz0f
         yS0w==
X-Forwarded-Encrypted: i=1; AJvYcCWggu8IaiOO2pwS30aVF8Q/o9UaN/w0XvXlzjIhmPdhfmRHSzmiuGKLGE1uxlgw2XU+Qqao94S29b8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgEZpLsJK8Tpv/uKz/OMNqkX/XPAgTM5PO5p6kzNwcH4VgXyzR
	4izuXKxxFA+rPJhYMmYqUMS9b1QQmhl/W0fZQJCHDifAC6nAqm+lZSyEuiCGSe13vSKTS64AAH4
	mw0Rw1j1fnMpstCcSTkJeB17GQXLSWea7vxUXtpuA
X-Gm-Gg: AZuq6aKuNgP43ECseRPweB3P6oFWvm5J1QkAD25lbKPCnwpv57FY4VJ0D2CooayVgKN
	O2W/Y7KkUKI8zVG97HZ3Z9KkgoDJsuQiPWhFyP0ft0UdjGvhiQga6hMvREE/vvCQgkmqeGWk5nb
	vDlogkpeMd4iNyBHl9DKLRSeHWMmjqSAGRbd9/MA8Bu7fhMOcmLAlibyrMVOOHGq/k8P4Bw1mQT
	f21nYbIW1Wx/8ETSp79DC6ZvjUJVGitVJUlKhXRC4tZXyl2MPbXoCmsFxaADHv0fG+IyVLq2dyG
	OGB+xtrRepcTkH6KV4/hJHYG9itQTSo9ZAEhEVH3ESG0Pw8B8gk2d4A4Mg==
X-Received: by 2002:a05:6000:2889:b0:436:1116:fea0 with SMTP id
 ffacd0b85a97d-436293b267dmr13879681f8f.59.1770627517365; Mon, 09 Feb 2026
 00:58:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121183719.71659-1-ojeda@kernel.org> <aYmgjEWaLrdsubKM@monoceros>
In-Reply-To: <aYmgjEWaLrdsubKM@monoceros>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 9 Feb 2026 09:58:24 +0100
X-Gm-Features: AZwV_QhznCYpnYoMY4YW_2SZsrqqWinsdT88yHc01cus7270kufkaww3dM4cdl8
Message-ID: <CAH5fLghHM7Wfe6n0FsOyEm2oHLUdLOf+OpZiXWnS+yRH4kJdCg@mail.gmail.com>
Subject: Re: [PATCH] pwm: th1520: fix `CLIPPY=1` warning
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	linux-riscv@lists.infradead.org, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8105-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,samsung.com,redhat.com,lists.infradead.org,gmail.com,garyguo.net,protonmail.com,umich.edu,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0EDDD10D492
X-Rspamd-Action: no action

On Mon, Feb 9, 2026 at 9:56=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Hello Miguel,
>
> On Wed, Jan 21, 2026 at 07:37:19PM +0100, Miguel Ojeda wrote:
> > The Rust kernel code should be kept `CLIPPY=3D1`-clean [1].
> >
> > Clippy reports:
> >
> >     error: this pattern reimplements `Option::unwrap_or`
> >       --> drivers/pwm/pwm_th1520.rs:64:5
> >        |
> >     64 | /     (match ns.checked_mul(rate_hz) {
> >     65 | |         Some(product) =3D> product,
> >     66 | |         None =3D> u64::MAX,
> >     67 | |     }) / NSEC_PER_SEC_U64
> >        | |______^ help: replace with: `ns.checked_mul(rate_hz).unwrap_o=
r(u64::MAX)`
> >        |
> >        =3D help: for further information visit https://rust-lang.github=
.io/rust-clippy/rust-1.92.0/index.html#manual_unwrap_or
> >        =3D note: `-D clippy::manual-unwrap-or` implied by `-D warnings`
> >        =3D help: to override `-D warnings` add `#[allow(clippy::manual_=
unwrap_or)]`
> >
> > Applying the suggestion then triggers:
> >
> >     error: manual saturating arithmetic
> >       --> drivers/pwm/pwm_th1520.rs:64:5
> >        |
> >     64 |     ns.checked_mul(rate_hz).unwrap_or(u64::MAX) / NSEC_PER_SEC=
_U64
> >        |     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ help: consider=
 using `saturating_mul`: `ns.saturating_mul(rate_hz)`
> >        |
> >        =3D help: for further information visit https://rust-lang.github=
.io/rust-clippy/rust-1.92.0/index.html#manual_saturating_arithmetic
> >        =3D note: `-D clippy::manual-saturating-arithmetic` implied by `=
-D warnings`
> >        =3D help: to override `-D warnings` add `#[allow(clippy::manual_=
saturating_arithmetic)]`
> >
> > Thus fix it by using saturating arithmatic, which simplifies the code
> > as well.
> >
> > Link: https://rust-for-linux.com/contributing#submit-checklist-addendum=
 [1]
> > Fixes: e03724aac758 ("pwm: Add Rust driver for T-HEAD TH1520 SoC")
> > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> > ---
>
> Looks good to me. I'll wait for Michal to add his blessing and then when
> picking it up tend to drop the Fixes line. Or do we also care about
> CLIPPY-cleanness in stable?

I think we do care about that.

Alice

