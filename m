Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5411DB0F3
	for <lists+linux-pwm@lfdr.de>; Wed, 20 May 2020 13:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgETLEq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 20 May 2020 07:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgETLEq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 20 May 2020 07:04:46 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF444C061A0E;
        Wed, 20 May 2020 04:04:45 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id w65so1544762vsw.11;
        Wed, 20 May 2020 04:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tBbP8YUr7lz0DfzrBkUhLuJYKJzm6eP47m/XASkMADA=;
        b=L5zPkmH7U3E6ezICqlMMZi1ISnVgNFKlWSqsW+/zJ5kPbkEksNY7eBRW3OooQ4hxHS
         c3H2M+dTWRW4HTw+TIwwZi1LCJLTvCKxyQcYuwhuYoa/n2eqIlpRcOzkAvDYa0REcTJq
         VV/EZJOTN+MJ8QXIzyqt9C9RMMzhsePk3vzUPr3CEGO4fsaLc8ns1ySMjdmlVNy5arJj
         NtSnTSqUmQauw0Nu49ZQQGaa4eMbzVQejDUM8jmPQyRGfT2Yo7dK5Idj1Pkmle9mf5o3
         +q4FcFKQsouGXwXuBfcuS+OYm4K0pG9AKg4wyOVyWAHoO8pWb5jvLj4jVJB0oUplKhWW
         dNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tBbP8YUr7lz0DfzrBkUhLuJYKJzm6eP47m/XASkMADA=;
        b=U0bbkuSpOtkoppm8p1WzJ0DLuoJju6OEWteE1F5xc2qrnZUWDdVuzRhjS7PBLOMUZE
         2S1bTpO14IFe6PKT/bkXvOY4Ynyr03gIwqWSAM7lEeYiVJlDjptrQfLYWK32EbfIOrvI
         QjcAPH+mN5T7X/5cp7gC0gZojI+PFRhPLwjLNxtnDsa1qbdBBbD9AErfCc1iJzsK186/
         ojcEJyDv5Jz3f+NncvV2NkSEYWTRpOa0cOObJzveopD+Uk3DgBRr+eVuc/SB0JBqqQ38
         fKtOuNTa7PnhjeG8AbPVtj4P/RZWCTBn+bPmMGDj7fG9TaCh1G571qf8GIYGFyK4S2/t
         lSSg==
X-Gm-Message-State: AOAM532NTPIeg1qT25Gf1i95e5fsA2nj9sD/vd4JD/hc3aQsEZMXMe3K
        Pn324UIG9UnL0RMSEjjgcqL7jZ9ZY8bwOHFAVls=
X-Google-Smtp-Source: ABdhPJyq/ffWXGjhqdyiXYab3YCkhFT8RSfOHU5lo8o0RdgIi7Fkto4wUoS0zwbvDvdscj+nV5fhYh/UdA3pEjcKCTM=
X-Received: by 2002:a67:71c2:: with SMTP id m185mr2810685vsc.186.1589972685199;
 Wed, 20 May 2020 04:04:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200517190139.740249-1-sam@ravnborg.org>
In-Reply-To: <20200517190139.740249-1-sam@ravnborg.org>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Wed, 20 May 2020 12:01:50 +0100
Message-ID: <CACvgo50OVFL1fNjmaVFRzDQANMipC9q1EiMN4CGoQHvtY3H14w@mail.gmail.com>
Subject: Re: [PATCH v2 0/16] backlight updates
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        linux-pwm@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Andy Gross <agross@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        patches@opensource.cirrus.com,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Sam,

It's a little weird to see this series, just after I mentioned that I
had one in the works.
Either way, patches 2 and 16 need some work. Although if you prefer
that can be done as follow-up.

For the rest:
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>

-Emil
