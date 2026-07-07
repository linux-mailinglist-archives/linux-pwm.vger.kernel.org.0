Return-Path: <linux-pwm+bounces-9621-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IhqUGXP5TGqHswEAu9opvQ
	(envelope-from <linux-pwm+bounces-9621-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 07 Jul 2026 15:04:51 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAB771BAB1
	for <lists+linux-pwm@lfdr.de>; Tue, 07 Jul 2026 15:04:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=dNRNvkik;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9621-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9621-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2BDC33041692
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Jul 2026 13:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA046414DE9;
	Tue,  7 Jul 2026 13:04:30 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2AD3126BF
	for <linux-pwm@vger.kernel.org>; Tue,  7 Jul 2026 13:04:28 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429470; cv=pass; b=WQHIxxijrjCHAT/JVrqEAm8q2DkNN0Dh2sKck8uyL2F93l9t6DkpOAbulF8zfQwuIxefyt1NnzvO/qCnnNvKXEk83uBDAAA3RGb+xCqI5RZ7kCkE8GIfrVI+HvNKskxMQD+lZZ0MjWO5hBfoS1cIUmMZPk0wgiSnnGZ9RhvTjPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429470; c=relaxed/simple;
	bh=TmPGIYAzJvC80RsuDMRwEJ1EsP9UZtxlgsFYi2qUwwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oIL4Xs7NdN4HjYidSHuKzQEec1ogXHUOAFg07YrBtRnTzRVw7NKlRTpV45eEETQx18aRuv8xc9DCcR93rvMd8JMxUf1xEwk+GJu675vXIPxzlFS4uQjvPeCAayfE/WaixbsNHYNdNE+ES+Hd/TqB5IIaK28Lz1d/Jb+gaUf/VjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dNRNvkik; arc=pass smtp.client-ip=209.85.128.48
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493c52cde9eso41401615e9.3
        for <linux-pwm@vger.kernel.org>; Tue, 07 Jul 2026 06:04:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783429467; cv=none;
        d=google.com; s=arc-20260327;
        b=VsHN0g5oCN+VjjDu2e1O8ggLa03ZzRONHnpY42Grn//Fv+i1dLWN3C+0xGUxgywTw5
         qQWwLRN0XYIMzic617gGNm4ZLIScbkSccS5adY11xFXZGDE4zUPrBvhPu5viS7J+DWhG
         7hN9EWo8Y9OCUS9jmRiKzQd9uTu5tA4keXSROJ5hzPawFwCOJNPt4woY9JQGM2nRmEBL
         Igr1nX2g1gx5BbFaYtpo77cd9szSYKWYK/HCe1+wBdb5sWox/BEmMaXAgmePltbfGcsZ
         TiqOt9B6Y5jSVSbWIR5AnCJdU4+1EKMRuWltdMrFAIVzzFgkHFka8awADVHpMdiRj4hF
         sHlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kMZTTwd8MYpbLMhgPf9wJy+JM0u3tngYW75375hm26s=;
        fh=JNyD1bhgGCDZ9cj6Ifk1PHCUGYjVJ6T6qwkYlHalwrE=;
        b=PqYr5nhD2Phoa137znjRXVyDJE+2YkwdPdoAv106Mk7g1L0J5sEROxf/aBEGCTyL+z
         tfaFUQtNlU+OAPL/HS9FlOjWPINIPal22PoA195lga2iKcSAdu6EgAi19rn36RsUmwEM
         Lu3J3gHl3X/gRh7uAcdTHf0SSz7/cBW+BtFYYv15jCM6Wg2vUmEfq5/B5VhPHG1+beal
         bjs/ECdrT1IgzYNAL798dlR1+jNpE1mc33R4nDDUSseRm/84OpVgpvigFe7S3xbdr/0F
         F5zNiNsS0EcpH2/nNv7OBiu+mtZozHyC15ITZZNuwuAxubIzdlc7B4EJ/SbJtfF+AFLS
         kEeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783429467; x=1784034267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMZTTwd8MYpbLMhgPf9wJy+JM0u3tngYW75375hm26s=;
        b=dNRNvkikjxahImuUI1Drg6CXhxVxac7dmERU9WjMnbsmX5eHK8WY83RbZ6d8ZHmaOR
         obViGb56A87vfGXlOGE5CbAAs1hrc3UXO2XdohufG2m67EjQNWl3aM6kcmBgGlnhpXb0
         55N4uSy4UxvHsBdSOFUwN8a7Xi9ecmoWElcH41X7rtSVSWXt9PKW5oQc0sCPCWon1GQI
         UHzzE9kkhxCI83tNWa1pH1IKsm+3VVHfnK74tgTXhcNzcUaQuCRi71myU8x3J7bukLTo
         7OpG78s998Dgqd4mCuL/HwAzs93Lz6Hpr1UIbUvthgrkhpJuQ4eNyiuBinQ+gNC9MzBE
         pURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783429467; x=1784034267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kMZTTwd8MYpbLMhgPf9wJy+JM0u3tngYW75375hm26s=;
        b=chbGFBG8zciAj9iym9AHwym/6mYVlC9A4CIfE85jaGEzzUFxGMNAp/2AhqOuOV5xRh
         MAZF0jwf9q4vJYQSiD/Df3bBf/5Rz3sWxofidrUODIuf81QhjbN3JhsC2hz5KfY7S9hP
         pzxDVcBUfDoad43isQQkK2zbSI4tB84hRNTMtJP6jEXV0NLcCQtklEz6bZa5/zmLjA0r
         x3upZy0kiuWuWn8iq4NZTgSWcsBPeFueQNUTuQzwxTxSjNGgo1CBlDSDFR434Vu4i3vc
         iVpqml0YJSFR5Ps2lXqZTAYuoJhiR+N9gPNIbJZ9vokEIugWXWcoMKOtjKkwL+YLCEY+
         +p8Q==
X-Forwarded-Encrypted: i=1; AHgh+RqEdvVeCSSCxwIDr7TUPyU1GwiDU5IUgBvClxjK8dCBnqFQjP/9hQRPAAkrdnK5cMyMTWDZPaG80eg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvcCzpHwC4FZF/XnPhBMC4MYlh4xJ+4X/tYExWOp2klz1Gxpjs
	u8UdY2y1mSuOIOsIciwxa85vp+E1aB65UaM2B1r5IJlHlJhNpKgdO7syS0fsCmNnZRXiIMtHj5/
	TkIYRgh+JaOLhsiBjWHqIyVcWpzroT/RCXeBfFbbX
X-Gm-Gg: AfdE7clCGN//mIqQ4mO7Svy4WYp3nbwCWFnkPTsmLW35UKHMSAtMoKp7ZgdNgkVDCw3
	zd9jwLl22foHbTN8olW2AEKqazdts6gO1/koLWD6958prLQ4C7F5ym5E0m2wetrMqfe8/+k+r00
	MdeusdXhv4YzHgax/yJQeS/YukusVgQN+ZUDDEZXlc0NiWtz+8+6Qr+X88nUIl3HtFOBSI+cyEC
	g/U5jg5O7i05zvFQ9ECkJCybxNrxFM3ldVDHvV99qdAcCVSdLC8OVG2q1YQHrdm1kdFrAdnSxNZ
	+Y/5nKEYTb2KQ8KGISyM+/BgOOY=
X-Received: by 2002:a05:600c:3e14:b0:493:bc4a:e7d3 with SMTP id
 5b1f17b1804b1-493df0a08d1mr56240095e9.39.1783429465838; Tue, 07 Jul 2026
 06:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626-unique-ref-v19-0-2607ca88dfdf@kernel.org> <20260626-unique-ref-v19-4-2607ca88dfdf@kernel.org>
In-Reply-To: <20260626-unique-ref-v19-4-2607ca88dfdf@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 7 Jul 2026 15:04:13 +0200
X-Gm-Features: AVVi8CcTh9Rs6YX_7yLE2pYLhG0EOfuYJdmTfdwdI6hvKkhrcisIrByGWFuDPNk
Message-ID: <CAH5fLgguLAQG7mUwD1NPECYSsPdpPD_tLskU3NdwLZhKR1H=aQ@mail.gmail.com>
Subject: Re: [PATCH v19 4/8] rust: page: convert to `Ownable`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Lyude Paul <lyude@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pwm@vger.kernel.org, Asahi Lina <lina+kernel@asahilina.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9621-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:a.hindborg@kernel.org,m:dakr@kernel.org,m:ljs@kernel.org,m:vbabka@kernel.org,m:liam@infradead.org,m:urezki@gmail.com,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:tmgross@umich.edu,m:daniel.almeida@collabora.com,m:tamird@kernel.org,m:acourbot@nvidia.com,m:work@onurozkan.dev,m:lyude@redhat.com,m:gregkh@linuxfoundation.org,m:arve@android.com,m:tkjos@android.com,m:brauner@kernel.org,m:cmllamas@google.com,m:rafael@kernel.org,m:david.m.ertman@intel.com,m:ira.weiny@intel.com,m:leon@kernel.org,m:paul@paul-moore.com,m:sergeh@kernel.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:viro@zeniv.linux.org.uk,m:jack@suse.cz,m:igor.korotin@linux.dev,m:vireshk@kernel.org,m:nm@ti.com,m:sboyd@kernel.org,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:ptikhomirov@virtuozzo.com,m:m.wilczynski@samsung.com,m:phasta@kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:driver-core@
 lists.linux.dev,m:linux-block@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-fsdevel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-pwm@vger.kernel.org,m:lina+kernel@asahilina.net,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[aliceryhl@google.com,linux-pwm@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,infradead.org,gmail.com,garyguo.net,protonmail.com,umich.edu,collabora.com,nvidia.com,onurozkan.dev,redhat.com,linuxfoundation.org,android.com,google.com,intel.com,paul-moore.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,linux.dev,ti.com,virtuozzo.com,samsung.com,vger.kernel.org,kvack.org,lists.linux.dev,lists.freedesktop.org,asahilina.net];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_GT_50(0.00)[53];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,asahilina.net:email,garyguo.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CDAB771BAB1

On Fri, Jun 26, 2026 at 1:56=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> From: Asahi Lina <lina@asahilina.net>
>
> This allows Page references to be returned as borrowed references,
> without necessarily owning the struct page.
>
> Remove `BorrowedPage` and update users to use `Owned<Page>`.
>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> [ Andreas: Fix formatting and add a safety comment, update users. ]
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

>      /// Returns a raw pointer to the page.
>      pub fn as_ptr(&self) -> *mut bindings::page {
> -        self.page.as_ptr()
> +        Opaque::cast_into(&self.page)

cast_into() is mainly used when you have a raw pointer to opaque. When
you have a reference, you can just do self.page.get()

Alice

