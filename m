Return-Path: <linux-pwm+bounces-8071-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wO1AG9MvgmlFQAMAu9opvQ
	(envelope-from <linux-pwm+bounces-8071-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 18:26:43 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D8FDCC44
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 18:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 296F8301B906
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Feb 2026 17:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA2428750C;
	Tue,  3 Feb 2026 17:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cRVtDvHK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668A92F39A1
	for <linux-pwm@vger.kernel.org>; Tue,  3 Feb 2026 17:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770139598; cv=pass; b=qKpKyIFkPunZ9DjlGiQMX/JGJtswZxBDU3Q4CVVr14NMHHY0EZl5+iG/Yt33glOCwNbgSeSPLA9B7nhwqCliEsbmXhhNm7iDBFoWZa1Imfeic8J3UYtp/AlLLrvvNBwU0vfFpmw8Q73/LMCn40c82wW6IglqycYHh5glsRfUX3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770139598; c=relaxed/simple;
	bh=BVSKK1sQZS2pD9gylNFVpwd3l9Oh8g0ThiOWKnSHB+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mNLPNbqwublWNF3+GtD95YNtQwJpJOVWjfEUqLSMWO5RlsUL7l1ZcpGU9kkYy1cYFS2ZGaZ3ClBT3a6UEIZkTZHcMTOFxrPNpxUo0PAwUotlK6p1xdtIKUcIGxyYYTq03Z9/O3eaXOxiUqXAKrLVAdklUK8vJgjxZCGB22bGqfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cRVtDvHK; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64baa44df99so11855a12.0
        for <linux-pwm@vger.kernel.org>; Tue, 03 Feb 2026 09:26:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770139595; cv=none;
        d=google.com; s=arc-20240605;
        b=GxQUaiDeJYM993BIyNF0pAYdhqoaFPd7IBUajLCrrIFEdGSQUzOzHdUpjRbPiHapD4
         HP0sN1cmL1hR1XBTOyVQkmK/KBTXqtPAJZx/Pl7WPB5Yxs0WTeM63HlboE0rvag6qtk+
         JqkkXYoaYR5eL1648Oy9l1im90P0dryeNxkNUm/N9PKOrO9WeVvb6Me4hHF1x2BlXqpt
         erQdNJ4Y1yrwxhHWUdrjW4oKq8oPnSjbQADV8tsA12j8qVrcRnJc7/qgirdifnqAOXZI
         TPWJIBLt1xNjLmtWMe0MvS+GaC/Gi9vEmiWG4ke4UJMC5wlUEzm2xB8M+xVf2zZ/szCz
         894A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TNaiJtMpISY5S0HDy1ONbkfjtxu0QVlIHfgawUN5ajQ=;
        fh=kXcMyTwh2gH2bFZVMskFEwOrNLYDahe9JEW9As2iu5o=;
        b=heD6JwBeSXqdXi08izsY0umMfDSpP5Lwos7fmqy03aoMIcIToY4yedGw11TGD7qBtN
         LwAJNvLSD2QyhKFNYnafchltsmrDOJ9q5ws83cPnCOZfOHICv8m7agy7LT0L2nfpXe4G
         QOkirwTQGklljda6e9slskhNJb2oxUDs8/j2YY6VUSGdVfH31ebGpdK0R1WoEc4W4F50
         BVcJ8ScznkB+6scoupx1BR8zdEWyN/od2hc0yN7J+tSH9PRXruSQJV+OpByQ5fstJqXE
         K4UhmCQGsiN1mVp2QhJw9Z1LY3iMWniTQXlqj+fgRcKGd5iR/j7EflfuDj2rJ428tup8
         bU0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770139595; x=1770744395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNaiJtMpISY5S0HDy1ONbkfjtxu0QVlIHfgawUN5ajQ=;
        b=cRVtDvHKZ1hdi45l0mFK8144ns71gJBBgjK3D1LMEfl2bvFjbt/ehm0NEStPMHiJyp
         iJ/lmieawSJefy6IZqH8V0Gn0u2OFKSr/u5OKQxUBdkBO4XdMGy9EnGz02PSJstaQTkW
         xzBcGKsgsUe609B6tuYJWxirpt2S6SkaLwWELFo/26Ok/yGFEL+XxSeS84fQ/jasDoBy
         tYykMdPrUrS0ZkalnHJndY9czeea81uLfyPZXPtCZalQu4tlrRDKLCRtUoaA45FfXJYE
         /VpQovQlN1c+CtRlqw98f3jIKUXXCm5zHQjF7/c8KZTRRU2bBlwv3cIeLgyCy8ZEYmTH
         VNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770139595; x=1770744395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TNaiJtMpISY5S0HDy1ONbkfjtxu0QVlIHfgawUN5ajQ=;
        b=nsuP8pWVBe1dhCP3Huwgf6M7bZ+UAn2lNdOABdXuXWZfEwF9/ANqGSya/4BMNwWrk0
         GFOTnl0YG9AlD1dx4xrQ47e7iDjISFiUoCK6Q4uEQfz592WtyO2R044gdQkU4VRxmMW3
         Hz5a9Ed4XbKY1Kjgc9D7SDEaMBs0WYyy5Y9jjK7ZOkxO6V0bawQCKA9RuJefWWDqyw2S
         bF0RdDPO4snXyop/ixSFifi8Hkv5Bh/bBz9vhuJ6tL9SkoDQMbRmba9W7vOXe96KA2PW
         hkj3MVcAR2cHRsq3/ovTFNNHkC+2XPQ7oUUAafGtG/uP6hTzI8CDZKOdVxKnGz19oPcq
         sgUA==
X-Forwarded-Encrypted: i=1; AJvYcCV9hL2B+ZTErqk85JEmjyHLhit+2bgBA6lm2PklnhZdN6tBjRpe010rw49H5ljHo4YG32EAeAHgM/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxAxMDAIj5J7/jLpxOMW6qDWGxhtqaFFY0/Um7VVZROgqJvLad
	qP4IStfuHrT34BHgTlLZ2tjrQJeBQAeXotr7QD3AknKKFICsxzv8fP+QRSWKjJ/IiqgrbeervYW
	cPdcVZfKBEmgMqB2S5c5sC9psDrhKGPI9o2Ckqo81
X-Gm-Gg: AZuq6aLRBhbdMdZZiE3TgbdibyHq2ycwbIaxdo6cgt/qAHQ1aphurKNVggXjcSaiyO1
	LJczHiF9gijdh+jlCZkruhuPg9fO5cjmPj+TXmTBjsFaU7yQHiyrxzICjabt6xLeBeatVct8uHN
	4WDowO/wYjo55ImUSRR/tlDjqQCbO9FuABgWhgWX9joMdIVC8b4VoUceONY7Y2HCHcdo8/WCLxT
	lh0XbU/xgjm8fxtbq6GLIwtl/CZXtVpzcxA4KvKuQQRCRT+jVse2jogWVMQJ6fjwA5bcc/6TQRf
	aGPPf0d/PmctcdqiuypNr01OiA==
X-Received: by 2002:a05:6402:3098:b0:64f:8fc5:251c with SMTP id
 4fb4d7f45d1cf-6594a353279mr5513a12.18.1770139594461; Tue, 03 Feb 2026
 09:26:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203-qcom-socinfo-v2-0-d6719db85637@google.com>
 <20260203-qcom-socinfo-v2-6-d6719db85637@google.com> <2026020315-conch-trickle-2d84@gregkh>
 <DG5H119NY68Q.TWLCK3W36CM5@kernel.org> <2026020347-sneak-embark-1b36@gregkh>
 <DG5HGZG62NNS.18BCSOO6TR70G@kernel.org> <DG5HX5K2T371.3JGY5PQIV554K@garyguo.net>
In-Reply-To: <DG5HX5K2T371.3JGY5PQIV554K@garyguo.net>
From: Matthew Maurer <mmaurer@google.com>
Date: Tue, 3 Feb 2026 09:26:23 -0800
X-Gm-Features: AZwV_Qh4ac161-isyLFn5NPWx7VX7FdmQ6d8uiNuPee-beDbNAjAyPPpvPjCwQs
Message-ID: <CAGSQo01qf4i6LDyi1umH6-6vjiE-VrFc1dd+qLxDXkjiYLcOCA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] soc: qcom: socinfo: Convert to Rust
To: Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Satya Durga Srinivasu Prabhala <satyap@quicinc.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8071-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,quicinc.com,gmail.com,protonmail.com,google.com,umich.edu,collabora.com,ffwll.ch,samsung.com,intel.com,vger.kernel.org,lists.linux.dev,lists.freedesktop.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmaurer@google.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C6D8FDCC44
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 9:17=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> On Tue Feb 3, 2026 at 4:56 PM GMT, Danilo Krummrich wrote:
> > On Tue Feb 3, 2026 at 5:48 PM CET, Greg Kroah-Hartman wrote:
> >> On Tue, Feb 03, 2026 at 05:35:24PM +0100, Danilo Krummrich wrote:
> >>> On Tue Feb 3, 2026 at 5:28 PM CET, Greg Kroah-Hartman wrote:
> >>> > On Tue, Feb 03, 2026 at 03:46:35PM +0000, Matthew Maurer wrote:
> >>> >> +impl Smem {
> >>> >> +    pub(crate) fn access<'a>(&'a self, dev: &'a Device<Bound>) ->=
 Option<&'a Mmio> {
> >>> >> +        if *dev !=3D *self.dev {
> >>> >
> >>> > How can this ever happen?
> >>>
> >>> You are right, since this resource is local to the driver, it should =
not be
> >>> possible to have another devce from somewhere else (especially not a
> >>> &Device<Bound>).
> >>>
> >>> However, from a Rust perspective I think not having this check would =
be unsound,
> >>> as the method by itself would not be able guarantee correct behavor a=
nymore.
> >>>
> >>
> >> I don't really understand this last sentence, sorry.  If this is "not
> >> possible" why would that at the same time be "unsound"?

The code as it stands doesn't do anything that would grant `Smem`
objects to something that exceeds the lifetime of the device. The goal
of bindings APIs like these are that it should be impossible for
someone to write Rust code without the word `unsafe` in it that breaks
its invariants. Without that check, someone could do:

let smem =3D Smem::get(dev)?;
let f =3D move |offset| smem.try_copy(offset);
some_other_driver_or_subsystem(f);

That other region of the code would now have ownership over that
function, and expect to be able to call it safely. We're not doing
that, but we're trying to design the unsafe API in bindings so that
you can't mess it up even if you wanted to.

> >
> > It would be considered unsound because the function itself can not guar=
antee
> > that it does not produce undefined behavior, i.e. it would otherwise be=
comes
> > unsafe.
> >
> > But I'm not an expert on this, I'll let Benno and Gary jump in.
>
> Yes, in this code, `Smem::access` is using the passed-in `&'a Device<Boun=
d>` as
> a proof that the device is still bound.
>
> If the check is not present, the user of this API can give in a reference=
 of a
> different device, and now you're pontentially providing access to the MMI=
O
> region to a device that is not bound anymore. A important property we wan=
t to
> enforce is that UB cannot happen no matter how an API is misused (it may =
still
> oops, which is bad, but better than UB).
>
> This particular code, though, probably should use `Devres` as Danilo sugg=
ested.

Mentioned on the other thread, but I didn't use `Devres` because it
being PinInit is problematic and I would need to encode an additional
invariant anyways.

>
> PS. Personally I think this check (and the one in Devres::access) should =
use
> assertion rather than `EINVAL`, because it is a bad driver bug when this =
is hit,
> and adding failing code path for something that is a bug is something I r=
eally
> dislike... It should at least be a `WARN`.
>
> Best,
> Gary

