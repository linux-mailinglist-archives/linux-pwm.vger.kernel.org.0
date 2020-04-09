Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDBA1A36D9
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Apr 2020 17:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgDIPUh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Apr 2020 11:20:37 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37578 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbgDIPUg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Apr 2020 11:20:36 -0400
Received: by mail-ed1-f68.google.com with SMTP id de14so181949edb.4;
        Thu, 09 Apr 2020 08:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=clzy1dbE4dM3+sTXvQLGQ3bT7gyjD6WOWMoUygp0K10=;
        b=drgWO+atC41zclomcunCM7dhMMA8QJFFJmVVjlrjKAb50VWcOOOxctudXXnG51Y4Ym
         uvAl34pbFg4hs9FNmdLGqHNKh1g6c880f0riDNk4xcr5Qv4eQY5P45RWBsTRciGuci75
         cdSejPXhyvl5D/e/w/NDajAZXhTjQoVJYKnNc8q9c4Y/yKgrbDikX6iYAUT7k6vqudNz
         HyF9iJmV3nZZB+ymXUKlqQamorAngpVZBz0Q3/cfZZKEBc1sTHfeiFOh7K9s1VrR/DSN
         Q5nzRgubzhhzRUaweAucOdBpNWKQfk0Ncex4IU161whGR0SadqqznA0I6EEo1JuHc7Vl
         CXnA==
X-Gm-Message-State: AGi0PuZhuVWvaxEiBUhluX5bv/OqVozwGh8la488RLStcmUrghy+Ik9D
        HRaGfrqFGt9ySV1Qk1WifRu5ywSQ52Y=
X-Google-Smtp-Source: APiQypIBbfRRaXcAZT5BWn+nX9KDtgAXyqqJjAFgotqpnWBfwY8+fvEeEFj/7IK4GGySJkFllNo9aA==
X-Received: by 2002:aa7:da50:: with SMTP id w16mr559039eds.54.1586445634871;
        Thu, 09 Apr 2020 08:20:34 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id ch5sm744313ejb.60.2020.04.09.08.20.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 08:20:34 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id s8so12342975wrt.7;
        Thu, 09 Apr 2020 08:20:34 -0700 (PDT)
X-Received: by 2002:adf:ec02:: with SMTP id x2mr14639381wrn.365.1586445634028;
 Thu, 09 Apr 2020 08:20:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200317155906.31288-1-dev@pascalroeleven.nl> <20200317155906.31288-5-dev@pascalroeleven.nl>
In-Reply-To: <20200317155906.31288-5-dev@pascalroeleven.nl>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 9 Apr 2020 23:20:23 +0800
X-Gmail-Original-Message-ID: <CAGb2v67GR2x2TJU_MVfD8S=gQO7gv4ohhfGBkLD2CtSCMyNktw@mail.gmail.com>
Message-ID: <CAGb2v67GR2x2TJU_MVfD8S=gQO7gv4ohhfGBkLD2CtSCMyNktw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] pwm: sun4i: Delay after writing the period
To:     Pascal Roeleven <dev@pascalroeleven.nl>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pwm@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Mar 18, 2020 at 12:00 AM Pascal Roeleven <dev@pascalroeleven.nl> wrote:
>
> When disabling, ensure the period write is complete before continuing.
> This fixes an issue on some devices when the write isn't complete before
> the panel is turned off but the clock gate is still on.
>
> Signed-off-by: Pascal Roeleven <dev@pascalroeleven.nl>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
