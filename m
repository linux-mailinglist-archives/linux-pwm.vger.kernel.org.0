Return-Path: <linux-pwm+bounces-8069-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMT4FsEugmk1QQMAu9opvQ
	(envelope-from <linux-pwm+bounces-8069-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 18:22:09 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8FADCB77
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 18:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9CF130B206B
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Feb 2026 17:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB442258CE5;
	Tue,  3 Feb 2026 17:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2zP9ygPz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59712652A2
	for <linux-pwm@vger.kernel.org>; Tue,  3 Feb 2026 17:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770139037; cv=pass; b=G5MRLjUC9fgI7itcAsbwvGxPn3h8JRIu1RZHhkQlfT8kJuorM2YfUr8lDPXGuDcpsxtoQp2NDFHa+PU3uGOWpWwwRlKNxc4QTVceT/VllVTOJUr4EIZPKu9n0BfgT2NyvWQgi3XptUHG4kXHJWixiCLzSmS5g/ywOb/BVxdF9QA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770139037; c=relaxed/simple;
	bh=UfW9ZbxSawettNRPZsiTFt/maBVXyJ58Op3z17lDyS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l3wVVOJ02A5R9sGQJayVeCfYwY+vPjFHzwNb3s/Ec+vt/r6QjXHBZro8fz2Nju3Lb/jGonazonsxSQA0y7qxytju56dE6ikJzh+WL4rDB2SpeVa8ywUWLd6fUoIdC4q1FbotU0E4SxzJuknwut2SdqHzdxsOi8qM9mvOVLYSTTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2zP9ygPz; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64baa44df99so11572a12.0
        for <linux-pwm@vger.kernel.org>; Tue, 03 Feb 2026 09:17:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770139034; cv=none;
        d=google.com; s=arc-20240605;
        b=X2qGsi7V6NrHcRA9ZhVDAUfOT732MBiL54LkdNXl04NFSC6nFYcAF2kD3yIxMu5Kdg
         /bpwWgKw42FxSBQOz0m9To0fOzkTGRFWT4RwDbwzrrA0JcR+aNfVSWvu1NOPP9F2rnCE
         7mbOm4RSJOVC+qMPz+IwmxTPKRx6/AhEQOUbSncAC7rGzjFGQhPZqIp/HA7WAGjqbomk
         gjhiccUQH0e34tSIDYQraNq6s4xGidORSGs/Bh1l8/pkajuJqtYJ8jjowdlwDePyf8ZT
         euhWPeOeaXxl+Kl3OqhfbXA0ZhMV8b4U7m3ZCEiFgNYQ0Ufx7hD0CQ+uzEazbf26dAhK
         4cpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XHfoxmbIC6zkgG4vIkE5TIaeovg1Amtxgwva3GX0OJ0=;
        fh=DDfWlLfn1y2Ry7PTlnB8q5cz6ydDeScjF8ZMWssK52I=;
        b=RFkXVHqcMeO6ngqdeq7g7vlnsqxHuHakDiDWXad6hp2O3vwAe3QWsM0JJXxPFBOcJl
         QBrwt9vVApZbMSHMQ0iygqoOs7wzRMkRjytCv95qKq+fi3NVRrZ1J3iXX/SHOnpWYHgb
         IFp+iR/iySyPC12O9Cp/fwW7DJVhyse2+IrlHy/KNc9Dtm20yfdCjWw9kcbmMg4K1v66
         PWNpNMOMQUdWPPsXeGfCuZXoTakbhwmy/2VW6vt82jImHraIKWqVsPFXFSy4GdiHQia3
         OQVdRaH1Z+NebPRGLR0PIijD35FlbWk6T5GJKF5uFG7KmQlXTtgd4cvdmZgV6N45ddNd
         PqNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770139034; x=1770743834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHfoxmbIC6zkgG4vIkE5TIaeovg1Amtxgwva3GX0OJ0=;
        b=2zP9ygPzccVKuiAOI6xTBQpsDESi9xsN6QT2mfVqjkIg6XHDobTajpmX3KeMiMhJ26
         5xBHIFz8pBVqZCGxkUzrnncQAYGu/f1MbkIKoTa1APp4gAU6sU7namwRuXPiyLX4ehRa
         vW2mHaj8UMF+hMlnqhG5kHjaSzSLmRA8gL8J2G3Hhmy2Knxjzs5xCmcNsFkokts/f2cA
         mnlk3z70DsT+fUtx2DgX8KZvlpflrwtr/c+m2uE/VuDowMQetQNsTSvKHrk/HQ1WlCls
         AOCLeMG5DQp33lBySEkNwroGTO0PT8Rjs9RT28d0QQ2B469pJPHEzmUT/XrIv+FoQsD6
         /+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770139034; x=1770743834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XHfoxmbIC6zkgG4vIkE5TIaeovg1Amtxgwva3GX0OJ0=;
        b=KXM/sRhEBZIHplO34bQ3ddZ54c+VqS4oArW+eingaSl7b72TVoUVM8JV6am44tMdE1
         IOfMcl+LlhTuNBoFVzIVNYHj46kF/2B/+iXu4X/DmgMmzpvvJGnNY9wj6GTlRpqj2fji
         ah2O57xziQkTa+h2OQPqJcAK0jwEjkoU0i5A+/A52OdNU1VAwVRvn2c9wIsdQnTTn7pB
         zGBkCjuUMMRdsLS1AyP4I3lStagXShFLWbs/YW8MQEcNfnhKcpBhvFQ7ESjEIQf0q2Sd
         avB6LuYEhlMtGLVBKO5dLKAbV0pEfhvNWRtMZ1AgoQtrjHkcUMgR156iAg36RqzxTA5A
         R88w==
X-Forwarded-Encrypted: i=1; AJvYcCWyjUlHDfbsbyvdvhSow4N7WqjJ0QhhlrMg2DAHCFSdkyg/BhQ7gV68eRsjn+lTDRxxBqMQA3y2MXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGYPYioaQvgzZzu9Z177Fmqwtf7dBonOj6aC60cgwl0oYNAoR+
	sS03fo9HFnv2M91TsD/eKRuHHhDrVc2id4rP9GySgZbQkJs8cXhXsRKpLKNOwVW5r6d/w8NMS9u
	PyaRi+rTUrqcGnBuv86zvdSITrZ3XMccytX0X5Ztx
X-Gm-Gg: AZuq6aJtree/tGozldXG62d0+YtweHLYMfcyh4ECnsicQD8TB9BHJGkL8s92wRORojn
	omgXTcYpiPyc9KZmf5o/jYSOZSy2nU6lM8wqTDiDy8VQDKoheOkIMgYJbGGmi7BlR6iqGoQcGEa
	CJeGCkkx2BkU63jMM7QeNzbt1c+htHuVJ5ztvg2A8dPtSG97CnvTI2tRGruON2PgWKWRt9L7Pr7
	yWFyz1O8CoTV361MgKhOdTkHPaJ7iyZDWbLGoNTod4EGHkxXcACMc/lDcPJw0otibvrwo5jF28H
	XtTOVpNASz3v/CUwOwsN4ahWG3cCUGF1nBgt
X-Received: by 2002:aa7:c1d8:0:b0:64b:53a1:7b09 with SMTP id
 4fb4d7f45d1cf-6594a34b6damr3702a12.14.1770139033838; Tue, 03 Feb 2026
 09:17:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203-qcom-socinfo-v2-0-d6719db85637@google.com>
 <20260203-qcom-socinfo-v2-3-d6719db85637@google.com> <2026020338-gratitude-overplay-98b0@gregkh>
 <DG5GWC5MR1ZC.3VFVRL0G0NMUW@kernel.org> <2026020342-dime-sharply-3fd4@gregkh> <DG5H9N9QKZUW.3KLJW09OBNRD0@kernel.org>
In-Reply-To: <DG5H9N9QKZUW.3KLJW09OBNRD0@kernel.org>
From: Matthew Maurer <mmaurer@google.com>
Date: Tue, 3 Feb 2026 09:17:02 -0800
X-Gm-Features: AZwV_QjJ5I2wN6j4AaSDIxHXnmaEEy8I5VLzgVrY-Rhll20Eq-wK6CGJrbI2UCY
Message-ID: <CAGSQo00M_6-6S3Yr4sLdGkNH_KAgP1FoC3zbdwdFuEOxic5vqA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] rust: device: Support testing devices for equality
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, 
	Satya Durga Srinivasu Prabhala <satyap@quicinc.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Daniel Almeida <daniel.almeida@collabora.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
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
	TAGGED_FROM(0.00)[bounces-8069-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,quicinc.com,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,collabora.com,ffwll.ch,samsung.com,intel.com,vger.kernel.org,lists.linux.dev,lists.freedesktop.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmaurer@google.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7C8FADCB77
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 8:46=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> On Tue Feb 3, 2026 at 5:40 PM CET, Greg Kroah-Hartman wrote:
> > On Tue, Feb 03, 2026 at 05:29:16PM +0100, Danilo Krummrich wrote:
> >> On Tue Feb 3, 2026 at 5:17 PM CET, Greg Kroah-Hartman wrote:
> >> > And I don't see what patch in this series uses this, am I missing it=
?
> >>
> >>      impl Smem {
> >>          pub(crate) fn access<'a>(&'a self, dev: &'a Device<Bound>) ->=
 Option<&'a Mmio> {
> >>              if *dev !=3D *self.dev {
> >>                  return None;
> >>              }
> >>
> >>              // SAFETY: By our invariant, this was a subrange of what =
was returned by smem_aux_get, for
> >>              // self.dev, and by our above check, that auxdev is still=
 available.
> >>              Some(unsafe { Mmio::from_raw(&self.raw) })
> >>          }
> >>      }
> >>
> >> It's used to ensure that the Smem provided by the auxiliary parent can=
 only be
> >> accessed as long as the auxiliary parent device is bound.
> >
> > But how can a parent device ever bevome "unbound"?
>
> It can't, that's why auxiliary::Device::parent() returns a &Device<Bound>=
, i.e.
> as long as the child is bound the parent is guaranteed to be bound as wel=
l.
>
> The point in this implementation is that we need to prove to the resource
> container (Smem) that we are allowed to access the resource, since it is =
only
> valid to access for the duration the parent is bound.
>
> In the end this is equivalent to Devres::access(), which bypasses the Rev=
ocable
> if we can prove that we are in a &Device<Bound> scope.
>
> Having that said, the code should probably just use Devres instead. :)

Not using Devres was intentional because:
1. Implementing `subrange` would require more unsafe / invariant logic
with Devres. I would need to either wrap `MmioRaw` in a wrapper that
maintained that it would always be inside a Devres that owned it, or
wrap the Devres<MmioRaw> in a wrapper that encoded that invariant.
Then, I would need to propagate the `dev` from the source `Devres` to
the derived `Devres`.
2. Devres is PinInit, so I can't put it in a vector.
3. I don't need the destructor feature of Devres that necessitates the
extra complexity, because this is morally a checked borrow, not an
owned value.

I considered adding a more lightweight `Devref` to the kernel crate
which only supports types which do not implement `Drop` and access
through `access`, and so does not need to be `PinInit`. However, since
that would still require the manual dev propagation wrapper, it seemed
like it might be overkill.

