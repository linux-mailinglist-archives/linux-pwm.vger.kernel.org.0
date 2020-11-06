Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637562A9745
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Nov 2020 14:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgKFNzr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Nov 2020 08:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgKFNzr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Nov 2020 08:55:47 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03D5C0613CF
        for <linux-pwm@vger.kernel.org>; Fri,  6 Nov 2020 05:55:45 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id f9so2057101lfq.2
        for <linux-pwm@vger.kernel.org>; Fri, 06 Nov 2020 05:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c/21Txb66l6mAzu9T/BegbBEWYzwSWqxrKDRbjBWb4s=;
        b=pm4q52vwwGj0wIl+J0xiwQ3IXb1fGQTm0lKQtMpQbnSf3of/l7NSyEVccpDWqZ+STD
         jNw8esLa68jdr6IqSSo72Qfr6aBvqwU6RuafhtWQ1E/pE7vIQcQl/4SP4nDSqWLOjOyh
         JQojQsGQ+EQUeAZyDwHssyS+j8aaDHRApxdqhpEkdtatB9HRatjUvhJrx6rELc0jnEV1
         gQdIyftPjRVF9+Re3egIbL0MoLgEUpTMa5xA0/91UONRqnDwYGLMKpJQtY1vbkTZxSBH
         bSutQQ3ZPIXgjaYQWLN6KuY1g41IP5I8XFDs5w+UTzn95cOz8gTShEbj1A+pm+AznJJB
         FrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c/21Txb66l6mAzu9T/BegbBEWYzwSWqxrKDRbjBWb4s=;
        b=DFsBn9ifITQnTO3SWYXmC/nPE1OYcLZr5AQEeYNp+tW5pUUgLY8j0bnpjVxQEdiQ5e
         OtSpdzluiv6RlgpTAHbMQcjBzbuEYD133a87T7xUKCgGbh3NKE49Jbb7W0ds8VC3tdqt
         ZicQJmEv9uZyFlZEz/Iof5H1sp9ECvQ8pDJzNO8+A5DxZJ5je25TQiJRy9SvdSqrzYnI
         YoYuJg7BH6RRQuGSHcnBu1TlEZjnLLScVAvwYlpeIc6TzYZf8+X68kcHoKwwO06fM81A
         6OCcdYPhnQynbpEukgzBUy8SiJfBeqvis6o5KvUuOSN2+dHA2IlSoZ7GrPrdisNhWHuN
         zQPA==
X-Gm-Message-State: AOAM531Mgrm8k8YyAzMk/aQj6mJoqdXZ/TyT+Bp1lBYT9r15ct6K04/i
        KGJAmLG6MxkcdEqhKVzaICbuyDSXL/Xf7NUxwWa4DMUGCxGEtA==
X-Google-Smtp-Source: ABdhPJwZp/Y41keIpJyXGZ2O8e2RatZsGj6oaEdbVbn9MGLBZmbnnXN+I0b6BUZrc5kbQ4pF7+CFiLnJV7sBdgeK3Rc=
X-Received: by 2002:a05:6512:322d:: with SMTP id f13mr889021lfe.571.1604670944172;
 Fri, 06 Nov 2020 05:55:44 -0800 (PST)
MIME-Version: 1.0
References: <20200812075214.499-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20200812075214.499-1-u.kleine-koenig@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 6 Nov 2020 14:55:33 +0100
Message-ID: <CACRpkdaedgUzBz8HTsSFS+ipTbZTHypB+oNBszA1ZDncWa5Y+Q@mail.gmail.com>
Subject: Re: [PATCH] pwm: ab8500: Add error message if pwmchip_add() fails
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Aug 12, 2020 at 9:52 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:

> pwmchip_add() doesn't emit an error message, so add one in the driver.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
