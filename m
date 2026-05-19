Return-Path: <linux-pwm+bounces-8983-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GlPI1qrC2ojLAUAu9opvQ
	(envelope-from <linux-pwm+bounces-8983-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 02:14:18 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C22F5756C8
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 02:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5C033013B79
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 00:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD0313D638;
	Tue, 19 May 2026 00:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d59lwcl8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com [209.85.160.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1D878F59
	for <linux-pwm@vger.kernel.org>; Tue, 19 May 2026 00:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779149651; cv=pass; b=UtfexEdp5CFglJiJnLmxBzhzpGRHU45WR0YZffpoUMWwN8bLNIgjcSza0Dlxj+3gomsdFqrtpBvBXSf6Q9JoqcvxqY7teZ1qEsnJl8ZKBDUIYce3ho09i2vhMN73qV2dZ0LsZ4L0neAsq1nQ4IDvgylRLX+yQXrkbU4V01VNFlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779149651; c=relaxed/simple;
	bh=LPwsRaL3/VhQKGJMHLIVfCwqYVCTUXR7opK9047JBWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TO4rv0ZmDgwtf/X3u+bgNYl8NnGyi2bM9eJNazdUgYTQrcnEFKOd+KIAWYUwEYjO6/FdSd9IuVTOvjLDJEq1GWKM/xXRXrozF8oYTAl/DZ3knFp4X/C1XvCpT3UIrFLyhvmdplXqc22W7Di5rLQVReHwaHZ/ejSnvYhg6W8wGhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d59lwcl8; arc=pass smtp.client-ip=209.85.160.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f193.google.com with SMTP id d75a77b69052e-50fbd79350dso34670961cf.3
        for <linux-pwm@vger.kernel.org>; Mon, 18 May 2026 17:14:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779149649; cv=none;
        d=google.com; s=arc-20240605;
        b=VCiUqaiBT6V1/j2cgy7NPnBLe90EgPmtuVY7zybgBcW+rDXfwVQDbUpqqQ239icWKt
         21qDhWJjbhNJJ5OQqAZVSjPrgduuf6uQO5AcYBSl5zwz5AKWRMIhnPbouEbQ0ELjE3C/
         O1+NaEo2/S3L33hF9UHGrOAwcCNy8yf0Uk1QjXWrkgLFtpUIkxgkZOc7YJ+EYAqEhVyt
         LXcz2XtkGBNLKToNYU4OffrnsjX3fmmWFe/DuZ3qp7uCVI1aB1GNBvI7elXN+dE6UKcI
         ISr0O2r7ihi6xeMXJPvR0I8TxmHT8gYogv8f1MEwCnbIxinmJDT9PtL+lWb9oE207O/h
         Fm8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LPwsRaL3/VhQKGJMHLIVfCwqYVCTUXR7opK9047JBWk=;
        fh=zAEusAIOIzok7Xc9b5fNtTb3NZgTg+mjwYG3yTKrPJI=;
        b=g7qP0G2eyRGupICDj7/PWOpbAXf69jCwtF33PZaWfSpWNgG9lTswNEhoqoQP/fmvl9
         YmKNRWhMxB2S0I49Lb088ori41oCZETa9xEYkYWvKLxef5AMCsM7WyecBK6YXW0PdcfM
         ZOQ4ywQWS/3ALrmC7RdtCNQySWd1hJePDYgjwJ1XQShtzNpHNkiW4uwiUB+rWMNUZNFn
         8k898GuTtxQ8uIlhpTNkFbPOPoCL8HOoNYefRhGd3BKuGBWuIRbS4AGqp/zkd+QN0wPZ
         G9s5W1HPRRBDSkx+2iQs43GHl62PBED7+QWUq3GGLmnF0Ll5rZ4Gntswh1005DT15xNq
         NUHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779149649; x=1779754449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPwsRaL3/VhQKGJMHLIVfCwqYVCTUXR7opK9047JBWk=;
        b=d59lwcl8NvuOHlMwJ/jtLfvIVKwSl887jI0zUq+n+MokZhIz5kSNG+Q7m83cRRj++o
         7S3rzqts7N4yutIkInkFXV9kygWG7yxiMPc0JWryBnFhkU7pGX5375FZhqllLsu46QxD
         yqRXefPbKqpNqDqlvNkmKy9NH53MH/MzNhs5i0t6EGN/qbHwnG3z9w6y+vTpWbbm4ui8
         +Y/emkK8/ZzUeQNXSb3F20EcO2qGGKw0KLfo5yfAg9tQxjLb8ir1PQn5DJpL6n74Uv7I
         Kzy/KgWqFZU9F5z3/y0h3xh8lwac6mtJi6nFuR/ealUBmYZWKM9xgcZKuPtDs3lS0PL6
         E+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779149649; x=1779754449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LPwsRaL3/VhQKGJMHLIVfCwqYVCTUXR7opK9047JBWk=;
        b=qc8MoFdd2lRB0YihNe7WiDyxUZbw8jdZOQ1wsn1qP/ocCOr6E+jssGYeRbUutjXhu2
         kEJoCqJkxGjvSOQLJnWnogj3gcinqLAvt1RNQqQskNAm1KX4ZJA3IshA21yv+prnwUaz
         sMMLotS22rpkupcyGaIe3fYN6WDSmuagsV7ovHaFblJc9CsNxHP0Pq+Rzj3gjJDVuIpB
         yNxgBrSdlyyaqqrh/SCZVRCX7EBAWZoIktWeQRz6UodajYQsHN8+KyOEOx9tPKmrRgeQ
         4zkf56ojcV7LPMufFK96pAC5XfJ6LWEYr4ER1KjQ4rf4O1VGA6HbzEhQ4HT9sn/0LNfs
         UnGw==
X-Forwarded-Encrypted: i=1; AFNElJ9jBioS7uO4PFi9c+IaiB6bPdC13jMvoBMeD9ul3mKiQPF8fxJe2tnfsdPTcRznZ44DfRGbXDHVQsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyKXkTamG3EaMkb7DT1Q0iWxLMnXfdqr3o1BMIClP0wT5TkIyV
	GGiJM+eQTRKHY/jqnDgB9G9EXyQ+0p31UKQNsoGpNzG4wSPmUsh7tT1in++KsivcB/5nZVUSRA8
	FuYU+XLphZWTz5jrrO/1hwvM21YOsWZU=
X-Gm-Gg: Acq92OEaGBxk9z2t+DDe0PuH5RSAUwyKslZfLUH/hVC490hEsEnWm9fJZu39SxHVjj9
	lCAO9E7i8hbIHfvp25tjNlUSnBbR4V2IsQJrcI/Ub6Wr5dHCVn13jDNH+TqV04rnCM1XlTqOFrK
	UBFMIIoszxiJ0cbvZx/0LKLlQsupWW4s3TuBHihUEanh6W92uP3PI9lrGZq+F8fy0YEjXngBEE2
	KqooZrq9wB9WX4+4SQQQu8WwLhWrg3edR8932feDmedgeBlNGRrc7kXea5NpTpAcguoF80lFYIq
	OvhwOGAQ6r/NXUTiGxlog87iUn7yvdaZP9uPL8H6i87707D3FUZbx3sFdq2Z+HJt9579s+T59OE
	bqk4=
X-Received: by 2002:a05:622a:d0e:b0:516:707a:cf8 with SMTP id
 d75a77b69052e-516707a0e9amr149948671cf.44.1779149648695; Mon, 18 May 2026
 17:14:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518042833.272221-1-enelsonmoore@gmail.com>
 <d40b1e80-37fc-4c88-9d7f-dae6458efe6c@app.fastmail.com> <20260518105735.GW3126523@noisy.programming.kicks-ass.net>
 <20260518172444.zyd47mcagrcwu7wt@dev-vm-schuster>
In-Reply-To: <20260518172444.zyd47mcagrcwu7wt@dev-vm-schuster>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Mon, 18 May 2026 17:13:58 -0700
X-Gm-Features: AVHnY4ICd7H9-70Xucdx9uJAfA9u6BhUaXyRyteuNE6Jo8mNtePRuTvmeSFjqyQ
Message-ID: <CADkSEUjhq6HSdg4ignzbuJiN5uXATsTdxFbRJ3BMxs5=WUWLDg@mail.gmail.com>
Subject: Re: [PATCH] nios2: remove the architecture
To: Simon Schuster <schuster.simon@siemens-energy.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dinh Nguyen <dinguyen@kernel.org>, linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
	workflows@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, 
	dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-iio@vger.kernel.org, Netdev <netdev@vger.kernel.org>, 
	linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
	Hu Haowen <2023002089@link.tyut.edu.cn>, Kees Cook <kees@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nicholas Piggin <npiggin@gmail.com>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Dave Penkler <dpenkler@gmail.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof WilczyDski <kwilczynski@kernel.org>, 
	Andreas Oetken <andreas.oetken@siemens-energy.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8983-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,arndb.de,kernel.org,vger.kernel.org,lwn.net,linuxfoundation.org,linux.dev,hust.edu.cn,link.tyut.edu.cn,redhat.com,linux-foundation.org,gmail.com,baylibre.com,analog.com,lunn.ch,davemloft.net,google.com,siemens-energy.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[50];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:url]
X-Rspamd-Queue-Id: 8C22F5756C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi, Simon,

Thank you for notifying us of your continued use of the Nios II architectur=
e.

On Mon, May 18, 2026 at 10:24=E2=80=AFAM Simon Schuster
<schuster.simon@siemens-energy.com> wrote:
> Unfortunately, as we are an infrastructure provider for civil energy
> infrastructure, the refurbishment cycle is a bit slower than for
> traditional consumer systems. This implies that the traditional LTS
> support duration (max. Dec 2028 as of writing [1]) is rather short, and
> we would be glad if we could keep the architecture in mainline for at
> least 5 years and only then "decay" to LTS.

Your reasoning makes complete sense. However, there is an alternative
to maintaining the architecture in mainline.

The Civil Infrastructure Platform project maintains super-LTS kernels
(and a set of base Debian packages) for 10 years. They are intended to
be used for exactly these kinds of devices.
See here: https://wiki.linuxfoundation.org/civilinfrastructureplatform/star=
t#kernel_maintainership
and here: https://cip-project.org/about/linux-kernel-core-packages

CIP will maintain kernel 6.12 until 2035. Is this long enough for your
lifecycle? What kernel are you currently using? If it's newer than
6.12, we can easily wait until the next CIP SLTS release to remove
Nios II support to avoid a downgrade.

One important thing to note is that the default CIP kernel branches
are not equivalent to standard LTS branches and include new hardware
support, which has a higher likelihood of introducing regressions.
However, the -st branches do not include these changes and follow the
same patch acceptance rules as standard LTS, so they are likely a
better fit for your use case.

Also, CIP focuses on architectures used by CIP members - currently I
think they are x86 (32 and 64-bit), ARM (32 and 64-bit) and RISC-V.
Since Siemens is already a CIP member, you can simply ask them to add
Nios II to the list, and you can assist them with testing and directly
submit patches to them once the standard 6.12 LTS period ends.

I hope this information helps you decide on the best course of action.

Ethan

