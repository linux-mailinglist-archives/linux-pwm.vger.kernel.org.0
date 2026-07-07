Return-Path: <linux-pwm+bounces-9622-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pnPaJ975TGqZswEAu9opvQ
	(envelope-from <linux-pwm+bounces-9622-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 07 Jul 2026 15:06:38 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 237F771BAE5
	for <lists+linux-pwm@lfdr.de>; Tue, 07 Jul 2026 15:06:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=nFuoGDO1;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9622-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9622-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 093F2301F5A6
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Jul 2026 13:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30247414A22;
	Tue,  7 Jul 2026 13:05:03 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D8D24B28
	for <linux-pwm@vger.kernel.org>; Tue,  7 Jul 2026 13:05:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429503; cv=pass; b=uPnAxNDwINxqRIfZd+nMGNQ7gXASDEUOh6vRfw87n6fOEzdciAee6U2rDraSo1YpJPkKER3SxeLWFTRw5WtQBvMudhIZ8C5p4ZVWy0TCamMKzovIBfFvwzeIS7vYP25TXkYJMVh842d55gHLRxm/z5WCebVUfpe1+5GvwpJg6bU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429503; c=relaxed/simple;
	bh=Qa3HvUOBiikHOm2hv7akwkWqjggqpxhg4jyWQbcbbM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V+z4JM7Rm4w+y4Y2KK6srp6+69CkmCiZxdE1f5CXJ6zxE0ivYxmSVF0g3H274/4+slL7y5WD3jQpenQH7UhjnkxAVycglxPIL3CHFg/qG9/vdbjKrByg22SK+BdUSxZV1Ink6RMDF4yKAFzYowA6XXty9dzMzOiks+ohlha/hSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nFuoGDO1; arc=pass smtp.client-ip=209.85.128.46
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493c7902f47so25664385e9.1
        for <linux-pwm@vger.kernel.org>; Tue, 07 Jul 2026 06:05:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783429500; cv=none;
        d=google.com; s=arc-20260327;
        b=s24xvaiviEfqywgX2lH0c5dy6gRysZi+u42wjsTdgSGazQMZuqOxmNb+kPCuUz2raj
         fpiejMHNuzhgHc7Vfl8ONpm+5Gf3Ma+y64HZteWK/IAkPHfmx1k5vsUmra0WG8FIR3f9
         3mxtZNdWaH/viwVj5ROUFfoZcfaOLYEBzLnDobtPvSxigQvR2TPVNJwyjt7nbIYGFFxl
         CI7OXE4g83nJmUmsgEGZ5jAzYSGWXHp+jhTcY51QnLyikoO7Usia8WCpeP0slxKSo6o1
         eQtfCbdsPrdjKnax3gY/5lrjGV6OWwT40O39Hvu3ywjn6duKS3mETkvWdg2Ytry5wQlp
         tMFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qa3HvUOBiikHOm2hv7akwkWqjggqpxhg4jyWQbcbbM4=;
        fh=4izJQ+j3B1drGVyyJWEv+5G3a2KZapYRZohngaB98/4=;
        b=Cu5JGF/tVYE6ZLlogy+NvAPW7bs3+wMj/KoqEqmQz3wLEZ6TChqZ1OrtpvFCYY7T1A
         Z4vqYhcWTbnAbnXkeewQ82Xj1+4DKZmHNUQOm2GKChJOMrSBbX0QowBndg44BQcL6VO/
         WdAAhJYSiFl9PyFf+HQXofesJaAIf5QhRwANBiqOXJA9DvR11JHscpAE1bbvpRlaO2Ln
         lu+TkYdH3VK9Nh1+lZ2cba7EeN5itVdWaF1h1loxjFtuk/gzmQKuP507wqHB1cCiwEqz
         5d/KyyiYU8d3+FQtumFe60V+r41Pm1JcFhhwwiAzDgPngjC+my/gNtN8DBB5rItBW1lO
         nBLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783429500; x=1784034300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qa3HvUOBiikHOm2hv7akwkWqjggqpxhg4jyWQbcbbM4=;
        b=nFuoGDO1XVGBMA2elJau60FW1YO9XoQWxecIiAhwpEOINYiWTEOvFYt9hryXEB1WFp
         +QpoHqW9prtXfUsoH9gorM2w2zbESlVhTgBwWgFdBoQW9ffxpI9Ftbj6KmIlr2kWa6Jt
         NEPjLGQmB/DlSSegsKGXACj8uniH8D+auFU3m9gfLKcnrWuuR7QuZ805cCIl2qBjA3h8
         4/C46UWq7/jViq9R3oxUB2NVe67Bo4SZB+0PtDp/OKTiKwcSYsSFdJgFbeUvRSF49jgc
         HgxxGmEIvlQrVRqPxxghfaYKwpTlJqLnq5f9qbYOax8CC466Yf8yNEGgUn06r4R/wM8g
         nqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783429500; x=1784034300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qa3HvUOBiikHOm2hv7akwkWqjggqpxhg4jyWQbcbbM4=;
        b=tPNCFNq14GFoj2hGn3d/UMAr4RvPoAGaGX3Sf7oVdMuxWlhhiAJbL26NXCZxOGzwOA
         vpbOvoCmuHNXWxjCp8OqF/NQ3WpEFnhmtUoNGLx2hMoHrX8JxhUy0JeCJjPRmeUY8PtN
         AWioM5e0CpphmvlaigzGXlIGFlPiOhz7psDwjw1Ad/uIoePc/8aZ25mX+Gim/7mY7V0E
         yBvrKgwyUBlxzOnD1euixvosgsSA58hF6SBuybhLDuMiRnYngHJAcBs3Q4QdqSxuPqcG
         xZTdPdf1sLxX6+YGJZ/7c8Ve661pTrKGduJ1hhjGD6vhoVzY8QP2pB0mYfHjMK1DMeXq
         gq0A==
X-Forwarded-Encrypted: i=1; AHgh+RqvMeST7t3qNjZV60544Tjyx7zzNR142QKqkBxAvf+BRghnqFARucFUxLuIFy/G4zo0+ZvmB8ex+ms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8eHCrFT264t3yafCwN2A9uyYBGlEsTT3HD+th65pvb25MmUqn
	8Lpis+196pxIMYxJrGOYmlS3oGsosRm3AvZKnBoL1ZULENZ7n2QbT00UUCc1ezuZDBQ9yeFqH2I
	FODRSN9Kfl1oDXgT41ERILbTsFoVE7zHkTgnm3+oU
X-Gm-Gg: AfdE7cmFuUlVd6l5IPhC7OwQw72503hktdZ/UOcy/R7F5E55QuIxhXPwsiRMYn/2JGb
	cNu4SYG7RX/+vW9yZSCmYv5+wRAZcWepxBXq4NDOespNmQ9VoL4+V/alS8VXNqkNSFbAyfrHA44
	RaH2KngRAh3NIA2imKbO7Up6UhoFwuR3Xx8W/0a4ouWvyCbpHsvw3e6wTmt9aJLCnVnZ29+ylps
	fa2crnhuRJ4J/LvPKUANzEFM9TxOtUBu1/Ay1HKoX0uBpyC9y1NuFWeQRflUrfwqyf/EzaZKvR5
	kxhtHMFr3cAO37+ukVnzKQsbj2I=
X-Received: by 2002:a05:600c:8b70:b0:493:b6e4:fb2b with SMTP id
 5b1f17b1804b1-493df06e943mr52096855e9.25.1783429497735; Tue, 07 Jul 2026
 06:04:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626-unique-ref-v19-0-2607ca88dfdf@kernel.org> <20260626-unique-ref-v19-3-2607ca88dfdf@kernel.org>
In-Reply-To: <20260626-unique-ref-v19-3-2607ca88dfdf@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 7 Jul 2026 15:04:45 +0200
X-Gm-Features: AVVi8Cd8GrEsrkEwxzhRkanTcpbMUA7MU6OpTudOnt7DIfIGqhosSlF_BI7LYTM
Message-ID: <CAH5fLggMeHUgXj7JGYSJejUrR2PdWymOOb+3E1VmHokzcox4hg@mail.gmail.com>
Subject: Re: [PATCH v19 3/8] rust: implement `ForeignOwnable` for `Owned`
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
	linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[aliceryhl@google.com,linux-pwm@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9622-lists,linux-pwm=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,infradead.org,gmail.com,garyguo.net,protonmail.com,umich.edu,collabora.com,nvidia.com,onurozkan.dev,redhat.com,linuxfoundation.org,android.com,google.com,intel.com,paul-moore.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,linux.dev,ti.com,virtuozzo.com,samsung.com,vger.kernel.org,kvack.org,lists.linux.dev,lists.freedesktop.org];
	FORGED_RECIPIENTS(0.00)[m:a.hindborg@kernel.org,m:dakr@kernel.org,m:ljs@kernel.org,m:vbabka@kernel.org,m:liam@infradead.org,m:urezki@gmail.com,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:tmgross@umich.edu,m:daniel.almeida@collabora.com,m:tamird@kernel.org,m:acourbot@nvidia.com,m:work@onurozkan.dev,m:lyude@redhat.com,m:gregkh@linuxfoundation.org,m:arve@android.com,m:tkjos@android.com,m:brauner@kernel.org,m:cmllamas@google.com,m:rafael@kernel.org,m:david.m.ertman@intel.com,m:ira.weiny@intel.com,m:leon@kernel.org,m:paul@paul-moore.com,m:sergeh@kernel.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:viro@zeniv.linux.org.uk,m:jack@suse.cz,m:igor.korotin@linux.dev,m:vireshk@kernel.org,m:nm@ti.com,m:sboyd@kernel.org,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:ptikhomirov@virtuozzo.com,m:m.wilczynski@samsung.com,m:phasta@kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:driver-core@
 lists.linux.dev,m:linux-block@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-fsdevel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-pwm@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_GT_50(0.00)[52];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,garyguo.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 237F771BAE5

On Fri, Jun 26, 2026 at 1:55=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Implement `ForeignOwnable` for `Owned<T>`. This allows use of `Owned<T>` =
in
> places such as the `XArray`.
>
> Note that `T` does not need to implement `ForeignOwnable` for `Owned<T>` =
to
> implement `ForeignOwnable`.
>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

