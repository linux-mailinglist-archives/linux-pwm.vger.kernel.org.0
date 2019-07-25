Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF78974E4F
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jul 2019 14:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388615AbfGYMk6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 25 Jul 2019 08:40:58 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39330 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388147AbfGYMk5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 25 Jul 2019 08:40:57 -0400
Received: by mail-pf1-f195.google.com with SMTP id f17so18714567pfn.6;
        Thu, 25 Jul 2019 05:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J/ML/61niP752oM19bE97gL7v9QOrp5SMkL6UiNcqYE=;
        b=PY7ogkWJSakBzZPZF4n2rjhfrfmSkjdugD/7CnQ2AqUGOsDzDMnWigVTfJnXOSd/nG
         OHvI4U1bWrzJc10q0ELDmuahZITR4TYwVJ3U2w7H6z7M1oLchLHnOOLYol3n/ELqfIHN
         +0MsLULuJdKSSZKIOOevgIyn+nmTJawaLgthP5bamahLF47jndtaNLyi+gIXTQobQVkL
         BIoSjO7QJEgIPzV6C2CyBOvtdA8yhr4972R5ZnEwIgmCPjEarOszKBCWPqWlaGYKnNaa
         yI1pmOeXcdlYxTV7oKBhiOVlLC7umlDnqTBUZOm4Z/uTcEkK6sKwX540uFSaK9HVZHFu
         OWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J/ML/61niP752oM19bE97gL7v9QOrp5SMkL6UiNcqYE=;
        b=YjYhDo3BE4SFpmr7ovwvKcdoCLIjldpREzmO76ZQUcZaR9HNPaTttkBl3rIKfYDAfA
         TMIGl6TInS+Tu5nrbJHO8kAOjAM5YwXgLDNLOk+MPdlolsn9y21m6KCYDlQCYTNgtXqr
         5E0V6KI1Nx7cFSkGphjWjOQn7t0/afJFD9GmrRBL5JjupMHmV6f7NJUH8KChPRabVF0y
         x8F6GvlBb5AkKVxqR+HNbUW7tuqMiVTyKTfvOEyJRribVQJpTXJxTJnb59xDdZDAZ4sn
         d3f+ilsO81DCyXY8vQYMAfAl6zibI6LpqEul26zb0h3xpomttGazBApKLiCmKMGa47qZ
         EeuA==
X-Gm-Message-State: APjAAAW2X71VreSNqLWvQGsb23pNn/zXDtCWk2c6DhpJ5wrtVYIGME9a
        N7ty6BdjW34ZljQwAxGeCSE=
X-Google-Smtp-Source: APXvYqzZVtmGtPxVfQ7kMqq6RGu0TK7XEyvGUo+ip6f/tN4SU+bt3iJP2qgOxVj7+4bnA9svqwtsOQ==
X-Received: by 2002:aa7:9786:: with SMTP id o6mr16119807pfp.222.1564058456426;
        Thu, 25 Jul 2019 05:40:56 -0700 (PDT)
Received: from icarus ([2001:268:c144:ff3:774d:cc30:25fc:d4ac])
        by smtp.gmail.com with ESMTPSA id n7sm57496320pff.59.2019.07.25.05.40.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 05:40:55 -0700 (PDT)
Date:   Thu, 25 Jul 2019 21:40:37 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 0/4] new driver for TI eQEP
Message-ID: <20190725124037.GA4802@icarus>
References: <20190722154538.5314-1-david@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190722154538.5314-1-david@lechnology.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jul 22, 2019 at 10:45:34AM -0500, David Lechner wrote:
> This series adds device tree bindings and a new counter driver for the Texas
> Instruments Enhanced Quadrature Encoder Pulse (eQEP).
> 
> As mentioned in one of the commit messages, to start with, the driver only
> supports reading the current counter value and setting the min/max values.
> Other features can be added on an as-needed basis.
> 
> The only other feature I am interested in is adding is getting time data in
> order to calculate the rotational speed of a motor. However, there probably
> needs to be a higher level discussion of how this can fit into the counter
> subsystem in general first.

I believe exposing some sort of time data has merit. Quadrature counter
devices in particular are commonly used for position tracking of
automation systems, and such systems would benefit from velocity/speed
information. So let's try to introduce that sort of functionality in this
driver if possible.

First, let's discuss your specific use case and requirements, and hopefully we
can generalize it enough to be of use for future drivers. From your description,
it sounds like you're attaching some sort of rotary encoder to the eQEP device.
Is that correct? What sort of time data are you hoping to use; does the eQEP
device provide a clock value, or would you be grabbing a timestamp from the
system?

I'm not sure yet if it would make sense to expose rotational speed directly as
an attribute. If we were to expose just the count value and timestamp since the
last read, that should be enough for a user to compute the delta and derive
speed. I'll think more about this since some devices may simplify that case if
the hardware is able to compute the speed for us.

William Breathitt Gray
