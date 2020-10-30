Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23CC2A05B0
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Oct 2020 13:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgJ3MpD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 30 Oct 2020 08:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgJ3MpC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 30 Oct 2020 08:45:02 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65F0C0613CF;
        Fri, 30 Oct 2020 05:45:02 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id i7so3174219pgh.6;
        Fri, 30 Oct 2020 05:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bbwRpqnCUeKVpHE5316I1lINTZIcCu55X9clyc18SBU=;
        b=gjoEOh3YC0CxSzs52rKBtGNXy1bVHTYXlLnJqjJDbhPr9RcA0eo4xS3nfybSCdf/PE
         CJc7jGxxo/LK5baELg8tN71DKxbn+o764iZNNM4qyl1zAYDj3itHzyWr3fCQv0u8Qlml
         RmK47O+H4JUnB6gn12ooroK/SiQM0qGu+Wha9gBqnzuYnoweg8fehVilWjckjzBDKRFo
         USvKjFqGcCDLxRslVBE6RqFvZr3Tep+r82wApTh6YwpjToSczUDMMR1i0C4wLallTdyA
         pb2IWwHMopZ8+e2qbxGh2DVLI4lGhx+CKxjqmZD6cmuw5okOgvNMx1AKC7O86PVnL3z2
         tDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bbwRpqnCUeKVpHE5316I1lINTZIcCu55X9clyc18SBU=;
        b=lH1DnNp15FptGDeEF6MCrONEuHjATOOqK1RWuGQD9e4X9O513DLW7dugCSZj6rWXaD
         DvyLLktXkwb2rdqeHpHHZjXRE09v3hP0nRGhoXMSeDa0YdlVyhGMEcy1LwoS1mOCVZuV
         OoUdkrf4Qpgxf8Tk54I86asjpsocGgHczlQh0yjvKsOu82TCQ3l4frZiVa0IPEsYHKBj
         zXUfCM4uTTMwJqTDQfDzKetJXDr7J0qEdKEicDsGV2XfuQtvf3IC9nVqcMKmX92vlvu6
         UxyOPPePfW9pSlxon8cWuEPpney0w2WeuA1cXztzl4mMvy8i5rooPauEyNI7omRY1TQ+
         OFQQ==
X-Gm-Message-State: AOAM533mPjMdHDRjdg7QawCAraWV2aVrmhNjOGKEcWQpBiUBjLgI70MW
        tgIpV5oKpo9lgDTkydiXQPDb0rFktKlzN9OhleCm0Sx2m58=
X-Google-Smtp-Source: ABdhPJzEmZeA13JLX3onIe39OzPkS7fr09+0uAK8ABcQxysahfrE0a2SweaPArflJ9X4IwsxZFt7Mhy+2Qmu2iql+ww=
X-Received: by 2002:a17:90a:fb92:: with SMTP id cp18mr2798347pjb.228.1604061902319;
 Fri, 30 Oct 2020 05:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <20201030094832.18297-1-hdegoede@redhat.com>
In-Reply-To: <20201030094832.18297-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 30 Oct 2020 14:45:51 +0200
Message-ID: <CAHp75Vewe7cLzqwQ=ph9iUGuaN_7f6+uk0QfP8i+iADa+Fa68w@mail.gmail.com>
Subject: Re: [PATCH 0/3] pwm: lpss: Misc. cleanups / improvements
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andy@infradead.org>,
        linux-pwm@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Oct 30, 2020 at 11:48 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi All,
>
> Now that the pwm-lpss / pwm-crc / i915 atomic PWM conversion has landed
> in 5.10-rc1 here is a small follow up series with some misc. improvements.

One nit against 3/3, in any case looks very good to me,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
With Best Regards,
Andy Shevchenko
