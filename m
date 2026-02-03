Return-Path: <linux-pwm+bounces-8074-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UE9wNno5gmmVQgMAu9opvQ
	(envelope-from <linux-pwm+bounces-8074-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 19:07:54 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C4CDD53B
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 19:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80DB83081051
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Feb 2026 18:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E3239C637;
	Tue,  3 Feb 2026 18:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KNR5uij6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE05364E81
	for <linux-pwm@vger.kernel.org>; Tue,  3 Feb 2026 18:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770141858; cv=pass; b=c65SkYRvn5zaI8ruU9zGHDR5vfAQaLhgiNc70d/JctdRR5bZX08eJkPk4cQRG14auIpTvKXhlszpDXhWlxzLV6iS/qcl+lJbniQ+BS8V6312IGkG7wfEzu/RxI+6pmw5yrlBGluMklInB2U50g6pjB35/H0ZoCpK9kuRmsUju34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770141858; c=relaxed/simple;
	bh=NiYmGhBDnkvI8ZJQgcCZNDyToFlarmUji712KD5FXgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aavt2zUaeuOSXhTNMGXE0M1KmVuikqdjYoNyeEnYxSqid831S2Tf4+ucdJUhIAl+gPmTffOWchKAS5+jNw0D00Kk0X5tE1KKf6dNh6OWt5dqLbCPfHN4GJU0Rl0DFJVa2MpGW/Px04CyLMSyxwvL4cPhMyfrTPDaxdpqEe2VHjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KNR5uij6; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-652fe3bf65aso278a12.1
        for <linux-pwm@vger.kernel.org>; Tue, 03 Feb 2026 10:04:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770141855; cv=none;
        d=google.com; s=arc-20240605;
        b=TFW2wP6tvPIOIriu7qt0XMsogcKfKdLpH7AnBpMl2Y4PfgS5IgCscFEYBTr1ne3a3D
         n4r0Aaz153wStQmE0oYMU9I50dMg0Dxg/HlA0TH3EmFx4CTq8WugL7z3ta3hBwp4Byw3
         g83uABKfN9Nk/O8wF9UDUI04w3IZQpedyRiG2h1di6m+1xeqBnC49lyIp6f6HajyeiXb
         tJQGhIaiyrjcnxmWVRRbXbpPsegVXUh62dn86Zqmj8O9SP2ZdQZXdPVhWwpEWRsMudGT
         /685MJJ3jg9X7kPFSqI+8frNO9c/0iHyNd6G6ieIIw7E80fPNtGrZ40hS1pmYgf5muKT
         Ws1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zo5g4kjzsHVdCYVph0+zHfHpTvTrsr3e0LsvYcnTAos=;
        fh=yMShX7R9cznEfF5PZKQVtIRpy5BALbFt6EUKS5bIkmc=;
        b=aW1tRomJADbqdXjiCoNp2BqEsTKDgmPEM+TRcSgyA1LRSeCW7RJFjUtU36noVN4Tz9
         ro+6E+5q+RZlfWVMfU9jQzehTv6p3XdR/0cZsZxGhLtFMXIPeiwUARt7ZRvnWz1kgm+V
         QkguhQXfmhfO8qbdtp4S79f/DrSAQ5/oWDzlvvkRc4eOyJcLT/SYi+O2HEmstu6rgPKb
         i+Yi+9GZc69O9a5naYNg4YhyI6Qq0CrndLpcH2jkKTD6z/Q8TuwDPbWMWhNm1Gfupfx1
         Jy/s0RCbsxVgsF4mGkXp632KVOa9mF+oKG8UuhFSrhCNOP2iXYoivyshxZIYKHex61IA
         Fflw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770141855; x=1770746655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zo5g4kjzsHVdCYVph0+zHfHpTvTrsr3e0LsvYcnTAos=;
        b=KNR5uij6C7FzK9xZwFmLsgZCkuZtZmjaWLp7PcA9CyI7xspZmm7CvlSzZMEwS3DgN9
         Cj9xbgNF1mV97TWI3f2ZGpsIo7h09OsDhH+kDMw9hux7PANFMxIa5O+85bgAB3fi2Czu
         Teeivr0u+gL2DWcfCVkfdT92MEfPWGnUQhPuAgAdsggDZMT7tI+OuSsL3a7/rcs7JkBX
         jNsFiDQKefQhCEg6HZl9NbXDeG+uGtZpARYiDaV+77a+plJcX5MiOrwtZNyJzADISdJr
         EP1XmBHgfNOQIXmZrahHQLxo3eabd3RoQECoa05lDa6iyKFyDW+USqo7lVIelyVnFj8t
         dTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770141855; x=1770746655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zo5g4kjzsHVdCYVph0+zHfHpTvTrsr3e0LsvYcnTAos=;
        b=vEEu7VUfY6LZY9bZvIsqPJg/K+SVbjm0LbXK75p6CGqv5HRxIgjh+2XTmKRLs3E1Lb
         HU7vU5Jqrd07AtTvjNfJVoQkwAgjOT3Y4qxKOwzfp0HJwngQddKr9N+q0bK68RgBSIAO
         ukLpVO/jVMyPIYq12kShoNWMdknqsY4J3bqrqhw2lhKilBttDHq4h+KwDOOqYf6FUzXA
         a/NNeRwioLYNDEdSY3FTiQREtUUIIj0907c7uxeCP9ktWWMehkXo0BrjB+eQjBPTigaH
         XIjjos9WtKDuR8/poo62Yge8102+Othp7g90af9QeG+X1BL4+VvC70wQ6DJu/yf4Wvyh
         ixkw==
X-Forwarded-Encrypted: i=1; AJvYcCXQEJSQMoyaR7qjIN2u7VkhkWTsqU43rA8EW3tpLEs21le7cHXdZo0DGp6JokK8rSB5zxJh0LcURXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX0DxtmnJ68WnoXrUun8/iNBnfyW19HcFcn1Mr2mshBVtA+fI1
	Jk493wf/qZYayf29FN5Qe6G0QE4qwnYyb/tzbi10yE459B8KsiJNwrB5AO3AdJaHTD8Sieaiq+v
	P5SE9ZoHm2nE09gz+r2X8SwnX0lIc0C/fMUXIP2cv
X-Gm-Gg: AZuq6aJhLTEYrXzFbIdX+pMqtS2e2ip3Hx5R5hrj27BNQb4UtuJYi5ic34U6ajf6qyT
	qqTrU7CIdxu2BhY5EVRXXQxP0VPCtY5ocSve5tyRkK/744iaYMK8ZOmO0gZXksXLFXRh1TxqMHb
	VYbwLUUMixMlzU3Q0vfrl4R2h4JdfDCzkgnvi30fVBeFBJpbNifAoQQMH8+aozwW9/kqkKpSPv7
	imAjdj12BJrWu+I8OtStzf1olRgbUQXp75lo+LwVg8xR9B0rGNLBbizA1RKv4+9s8gM3y8V/mKW
	iLwjQ+gUSt8sBNL/+FcltCPrNg==
X-Received: by 2002:a05:6402:5351:20b0:659:3fc7:e1e1 with SMTP id
 4fb4d7f45d1cf-6594a350f8dmr6491a12.16.1770141855228; Tue, 03 Feb 2026
 10:04:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203-qcom-socinfo-v2-0-d6719db85637@google.com>
 <20260203-qcom-socinfo-v2-5-d6719db85637@google.com> <DG5HAM6F5QYE.1ZFO7GD3SL9V0@garyguo.net>
In-Reply-To: <DG5HAM6F5QYE.1ZFO7GD3SL9V0@garyguo.net>
From: Matthew Maurer <mmaurer@google.com>
Date: Tue, 3 Feb 2026 10:04:03 -0800
X-Gm-Features: AZwV_QiFdGyk29eec1MFmYhNyUzLZTIr17YBC0D3LJX2IXJzzxnb_bKNmlHpqIg
Message-ID: <CAGSQo03g8bjRosYVPzxhK9FpSW1ZfW52unPaoxpcn=pXaDUriQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] rust: debugfs: Allow access to device in
 Devres-wrapped scopes
To: Gary Guo <gary@garyguo.net>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Satya Durga Srinivasu Prabhala <satyap@quicinc.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Dave Ertman <david.m.ertman@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, Trilok Soni <tsoni@quicinc.com>, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8074-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_CC(0.00)[kernel.org,quicinc.com,gmail.com,protonmail.com,google.com,umich.edu,collabora.com,linuxfoundation.org,ffwll.ch,samsung.com,intel.com,vger.kernel.org,lists.linux.dev,lists.freedesktop.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmaurer@google.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 40C4CDD53B
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 8:48=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> On Tue Feb 3, 2026 at 3:46 PM GMT, Matthew Maurer wrote:
> > This adds support for creating a DebugFS directory which is aware that
> > it is bound to a device. As a result, callbacks under that directory
> > have access to a bound device which gives them efficient access to othe=
r
> > Devres, ability to use dev_err! and friends, etc.
> >
> > Signed-off-by: Matthew Maurer <mmaurer@google.com>
> > ---
> >  rust/kernel/debugfs.rs | 40 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >
> > diff --git a/rust/kernel/debugfs.rs b/rust/kernel/debugfs.rs
> > index d7b8014a6474698235203f2b7d8fec96f2bb43f8..ac614d693fa73929d095b66=
9e9ba61958bec609e 100644
> > --- a/rust/kernel/debugfs.rs
> > +++ b/rust/kernel/debugfs.rs
> > @@ -11,6 +11,11 @@
> >  #[cfg(CONFIG_DEBUG_FS)]
> >  use crate::sync::Arc;
> >  use crate::{
> > +    device::{
> > +        Bound,
> > +        Device, //
> > +    },
> > +    devres::Devres,
> >      fmt,
> >      prelude::*,
> >      str::CStr,
> > @@ -722,3 +727,38 @@ fn new(name: &CStr) -> ScopedDir<'data, 'static> {
> >          }
> >      }
> >  }
> > +
> > +impl<'a, T: 'a + Send> Devres<Scope<T>> {
> > +    /// Creates a new scope, which is a directory at the root of the d=
ebugfs filesystem,
> > +    /// associated with some data `T`, enclosed in a [`Devres`] for th=
e provided device.
> > +    ///
> > +    /// The `init` closure is called to populate the directory with fi=
les and subdirectories. These
> > +    /// files can reference the data stored in the scope. Because it i=
s stored inside a `Devres`,
> > +    /// the init method is granted access to a `&Device<Bound>`.
> > +    ///
> > +    /// This can be used for cheaply accessing device-protected data i=
nside DebugFS methods or
> > +    /// accessing device-specific methods (e.g. [`dev_err!`]).
> > +    ///
> > +    /// The entire directory tree created within the scope will be rem=
oved when the returned
> > +    /// `Scope` handle is dropped.
> > +    pub fn dir<E: 'a, F>(
> > +        dev: &'a Device<Bound>,
> > +        data: impl PinInit<T, E> + 'a,
> > +        name: &'a CStr,
> > +        init: F,
> > +    ) -> impl PinInit<Self, Error> + 'a
> > +    where
> > +        F: for<'data, 'dir> FnOnce(&'data T, &'data Device<Bound>, &'d=
ir ScopedDir<'data, 'dir>)
> > +            + 'a,
> > +        Error: From<E>,
> > +    {
> > +        Devres::new(
> > +            dev,
> > +            Scope::new(data, |data| {
> > +                let scoped =3D ScopedDir::new(name);
> > +                init(data, dev, &scoped);
> > +                scoped.into_entry()
> > +            }),
> > +        )
> > +    }
> > +}
>
> I think it is a big strange to have this on `Devres` (in patch v6 it has =
`Devres::dir` doesn't make
> too much sense). I would suggest that we domsomething like
>
>     impl<'a, T: 'a + Send> Scope<T> {
>         pub fn devres_dir(
>             ...
>         ) -> impl PinInit<Devres<Self>, Error> + 'a;
>     }
>
> To me `Devres` is just a generic container type, just like `Arc` and `ARe=
f`, so
> the assoc functions should be defined on the concrete type.
>
> Also: is there a reason that this needs a special API, and by
>
>     Devres::new(device, Scope::dir(data, c"name", |data| {
>         // use data and device
>     });
>
> ?

Yes - that won't work, because the function being provided to
`Scope::dir` is `for<'data, 'dir> FnOnce(&'data T, &'dir
ScopedDir<'data, 'dir>)` - this means that *intentionally*, if you
capture any non-static-lifetime variable from outside the closure, you
won't be able to use it with the methods on `ScopedDir`, because the
`'data` lifetime bound should stop you. In the general case, we
wouldn't want a reference with the same lifetime as `device` in that
example to be usable inside the debugfs callbacks. The device of a
Devres wrapped scope is a special case because we know that it will
outlive it.

>
> Best,
> Gary
>
>

