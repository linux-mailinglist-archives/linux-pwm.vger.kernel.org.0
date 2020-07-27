Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E6522E667
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jul 2020 09:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgG0HU2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 Jul 2020 03:20:28 -0400
Received: from a27-191.smtp-out.us-west-2.amazonses.com ([54.240.27.191]:49740
        "EHLO a27-191.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726433AbgG0HU2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Jul 2020 03:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=7jvkchcrhflv7qhbkgrcypyraifp65wy; d=rt.linuxfoundation.org;
        t=1595834427;
        h=Subject:From:Reply-To:In-Reply-To:References:Message-ID:To:CC:Content-Type:Date:MIME-Version:Content-Transfer-Encoding;
        bh=aCADA11AxebQB9SZn73y6RAKnZyvO8N6LmX+sTsj0DM=;
        b=Ob9NRX9Mogwde+b2XQc3ED62pMQc6Z/YxtHNcCPrfTAixxcY9P3DnOH9I/4BXRdB
        G70ViIl10ZoFw/K1KUyno+RI4D8kCPbkAB3IJemy3yZYGUDkT71yScoANtdOaya2iyX
        Vxgfjmg0UFWvmfGYnLTfwP4RFlgGIQfXD+7wVXL8=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1595834427;
        h=Subject:From:Reply-To:In-Reply-To:References:Message-ID:To:CC:Content-Type:Date:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
        bh=aCADA11AxebQB9SZn73y6RAKnZyvO8N6LmX+sTsj0DM=;
        b=Xs6djVtYYo5YLGWAoiBdPgFLZrv0S4D3dXby69kZthXCkm0rh4HL+DDgabwJdUxG
        rgvrdQWWz0BdepnKWJqHwyZRFjCJp9eE8bZ3etfPLRkjuOj87pVxCpJ8r4dZAcVyr+6
        JA0WqHY6ArI5YJDQKGFvh/odSeMn5WNMW4zgbhXI=
Subject: Re: [Kernel.org Helpdesk #89942] Re: adding linux-pwm archives to lore.kernel.org?
From:   "thierry.reding@gmail.com via RT" 
        <kernel-helpdesk@rt.linuxfoundation.org>
Reply-To: kernel-helpdesk@rt.linuxfoundation.org
In-Reply-To: <20200727072021.GA2780715@ulmo>
References: <RT-Ticket-89942@linuxfoundation>
 <20200213102618.x5j6kfvqmdbx2pr2@pengutronix.de>
 <20200523170558.h2brqlf2jx4kee6y@pengutronix.de>
 <20200613141533.ak3nyo5hu636evwq@taurus.defre.kleine-koenig.org>
 <010101734f397f00-39d54a81-d06d-4947-b9fc-332e9f9b46d5-000000@us-west-2.amazonses.com> <20200723172702.nirnet6tbmwuwd57@pengutronix.de> <010101737cb6d988-bb70d517-bbf8-44b0-aa3d-4f9eed9101f3-000000@us-west-2.amazonses.com> <20200723173841.4geg4blngc2fwp4z@chatter.i7.local> <010101737cc18b4b-3c78b41c-309e-4d62-b6af-fd0536291eab-000000@us-west-2.amazonses.com> <20200727072021.GA2780715@ulmo>
Message-ID: <010101738f24e579-b69d3897-b823-41f6-994c-2755312a9af9-000000@us-west-2.amazonses.com>
X-RT-Loop-Prevention: linuxfoundation.org
X-RT-Ticket: linuxfoundation.org #89942
X-Managed-BY: RT 4.4.0 (http://www.bestpractical.com/rt/)
X-RT-Originator: thierry.reding@gmail.com
To:     u.kleine-koenig@pengutronix.de
CC:     linux-pwm@vger.kernel.org
X-RT-Original-Encoding: utf-8
Content-Type: multipart/mixed; boundary="----------=_1595834426-25457-3734"
Date:   Mon, 27 Jul 2020 07:20:26 +0000
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2020.07.27-54.240.27.191
Feedback-ID: 1.us-west-2.3ULHQnc20aILdVzjlbQ8UqO1WRWzA1U01b2uFAcT62w=:AmazonSES
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This is a multi-part message in MIME format...

------------=_1595834426-25457-3734
Content-Type: text/plain; charset="utf-8"

On Thu, Jul 23, 2020 at 05:38:45PM +0000, Konstantin Ryabitsev via RT wrote:
> On Thu, Jul 23, 2020 at 05:27:04PM +0000, Uwe Kleine-König via RT wrote:
> > > I'm sorry, apparently I screwed up and didn't assign this ticket to
> > > anyone when it came in. I was dutifully ignoring follow-ups, as I'd
> > > assumed someone else would be responding.
> > > 
> > > Chris, I've properly assigned it to you now -- can you please
> > > prioritise this request, as time allows?
> > 
> > Last week I thought this is a no-brainer now and will be done in a few
> > hours. It seems I was wrong :-|
> 
> I do appreciate your patience. There is a lot of other work happening at 
> the IT team, so your request for adding a mailing list archive has to 
> contend for staff resources with many other ongoing projects.

We've made do without the archive up to now, so I think we can wait a
bit longer. I think Uwe might just be worried that this fell through the
cracks again. If it didn't, I'm sure we can be patient for a bit longer.

Thierry


------------=_1595834426-25457-3734
Content-Type: application/x-rt-original-message
Content-Disposition: inline
Content-Transfer-Encoding: base64
RT-Attachment: 89942/2048391/1711212

RnJvbSB0aGllcnJ5LnJlZGluZ0BnbWFpbC5jb20gIE1vbiBKdWwgMjcgMDc6
MjA6MjYgMjAyMApSZXR1cm4tUGF0aDogPHRoaWVycnkucmVkaW5nQGdtYWls
LmNvbT4KWC1PcmlnaW5hbC1Ubzoga2VybmVsLWhlbHBkZXNrQHJ0LmxpbnV4
Zm91bmRhdGlvbi5vcmcKRGVsaXZlcmVkLVRvOiBrZXJuZWwtaGVscGRlc2tA
cnQubGludXhmb3VuZGF0aW9uLm9yZwpSZWNlaXZlZDogZnJvbSBtYWlsLWVk
MS1mNTQuZ29vZ2xlLmNvbSAobWFpbC1lZDEtZjU0Lmdvb2dsZS5jb20gWzIw
OS44NS4yMDguNTRdKQoJYnkgYXdzLXVzLXdlc3QtMi1sZml0LXJ0LTEud2Vi
LmNvZGVhdXJvcmEub3JnIChQb3N0Zml4KSB3aXRoIEVTTVRQIGlkIEM4RDc2
QzQzM0NCCglmb3IgPGtlcm5lbC1oZWxwZGVza0BydC5saW51eGZvdW5kYXRp
b24ub3JnPjsgTW9uLCAyNyBKdWwgMjAyMCAwNzoyMDoyNSArMDAwMCAoVVRD
KQpSZWNlaXZlZDogYnkgbWFpbC1lZDEtZjU0Lmdvb2dsZS5jb20gd2l0aCBT
TVRQIGlkIGRpMjJzbzQxNzU3ODNlZGIuMTIKICAgICAgICBmb3IgPGtlcm5l
bC1oZWxwZGVza0BydC5saW51eGZvdW5kYXRpb24ub3JnPjsgTW9uLCAyNyBK
dWwgMjAyMCAwMDoyMDoyNSAtMDcwMCAoUERUKQpES0lNLVNpZ25hdHVyZTog
dj0xOyBhPXJzYS1zaGEyNTY7IGM9cmVsYXhlZC9yZWxheGVkOwogICAgICAg
IGQ9Z21haWwuY29tOyBzPTIwMTYxMDI1OwogICAgICAgIGg9ZGF0ZTpmcm9t
OnRvOmNjOnN1YmplY3Q6bWVzc2FnZS1pZDpyZWZlcmVuY2VzOm1pbWUtdmVy
c2lvbgogICAgICAgICA6Y29udGVudC1kaXNwb3NpdGlvbjppbi1yZXBseS10
bzp1c2VyLWFnZW50OwogICAgICAgIGJoPXJFTEZQeGsvWW0vdWhQYWZFNjgy
M2syZzBaR1A2ektxeDhjQmFpWTEvMTQ9OwogICAgICAgIGI9WTFOMGNpR0pu
dWVkM2tmYm5RVXZXbFVoRkNBQlkzK2FoWEw2L3ZLK1VLVjNWckdXVlovU1NO
alFMZ3BSMFlmdE81CiAgICAgICAgIExQQnNDY0IySHZOWnVMdnZFWHBVZXM1
ekZOTmtJTjhkUU5RY2dyNk5ydG5FU2luN1lld244VWNTdlJWK3ZDRHRRTTFw
CiAgICAgICAgIGpCZzZ2dVc4U0NyNVhRWVc2dlNDSStYK2t3UWsrdkludnNW
U3lHVGpONEN2d3laOU0zUDVoWkU5TUhKU1kvMkJlZEFOCiAgICAgICAgIDhN
NWNNLzI4NkUvYnFTTW1jTFY4MytuRHNYNlhmVGQ0cGFaY3lsZHEraDNMajJJ
TlZXYkJKU05uNHE4THY1SFIxNEdhCiAgICAgICAgIFVwTXVhODdTN0dJanZX
ZWJlUUQySWpqdU1qcFh0bGcvc011Ryt3cXZDYUVLMktaY0lNbEFqM28zSWlu
cDIra0ExdG9mCiAgICAgICAgIFBrRWc9PQpYLUdvb2dsZS1ES0lNLVNpZ25h
dHVyZTogdj0xOyBhPXJzYS1zaGEyNTY7IGM9cmVsYXhlZC9yZWxheGVkOwog
ICAgICAgIGQ9MWUxMDAubmV0OyBzPTIwMTYxMDI1OwogICAgICAgIGg9eC1n
bS1tZXNzYWdlLXN0YXRlOmRhdGU6ZnJvbTp0bzpjYzpzdWJqZWN0Om1lc3Nh
Z2UtaWQ6cmVmZXJlbmNlcwogICAgICAgICA6bWltZS12ZXJzaW9uOmNvbnRl
bnQtZGlzcG9zaXRpb246aW4tcmVwbHktdG86dXNlci1hZ2VudDsKICAgICAg
ICBiaD1yRUxGUHhrL1ltL3VoUGFmRTY4MjNrMmcwWkdQNnpLcXg4Y0JhaVkx
LzE0PTsKICAgICAgICBiPXFFNkFDN204dWNtLzZDZUs0QXp4cDVzcHNYMzBt
OHBFdXZ3MHgxTDZLOEU2b1gwTzEwZzcxM0xORDlHaXUwanhGQwogICAgICAg
ICBJVWx3WW1COE4zTUVPaXpPYzFCZHpNRTdRa3hYVFZYSUhyY0VncEZoM0d4
V1V4YzVrTlJMZE4yWTdPOGxySGZ2SzZYcAogICAgICAgICBuenJlRGVVWmRx
Sk8wcVN1UitnVWZUM2NhZFVVMCtzcXBhbzZtZ1pYWnhTYm1VVUlLRlNISEd5
MnBncmNLSm5qNWFYNAogICAgICAgICBSY2NFUVV5b0tPcW5POURXeXIrZjJJ
QmluSGY1dldZMjN6UDhGN2RMekg5dGhycG5ES0xZZW5MMXh0emNHVWJGUEdM
UgogICAgICAgICBNK3JHdDN3M3E2M1lRYW5XdzFJaThNcnFCZXdtRUdZZ2dl
ZjhBSEszdVJlWlVtRFMwMUVkVUJHODNQR04zZHFtVmJOegogICAgICAgICBa
Tk9BPT0KWC1HbS1NZXNzYWdlLVN0YXRlOiBBT0FNNTMxOE03L0d2NkxMbDZ6
Q3I3ZlJBWFl3L0dVWXNVUEk4VTB0TUNrcW5LN25iRXJuSnZJOAoJVTBnWFZ0
VXV5T3BnVHhXa1RNWjVKWDdrbzg1WgpYLUdvb2dsZS1TbXRwLVNvdXJjZTog
QUJkaFBKd0FodnJVMFpPZ1pqWWE4RG5BMFV2MVVPSEdxNlNrZ1ZLS0U3Z243
ZHk0bDNSMmNzNGg2V3RsTHNtUWFjWTRGMmJzS0tRd2NBPT0KWC1SZWNlaXZl
ZDogYnkgMjAwMjphYTc6YzNkNjo6IHdpdGggU01UUCBpZCBsMjJtcjE5OTYx
NzEyZWRyLjE0OC4xNTk1ODM0NDI0MjQwOwogICAgICAgIE1vbiwgMjcgSnVs
IDIwMjAgMDA6MjA6MjQgLTA3MDAgKFBEVCkKUmVjZWl2ZWQ6IGZyb20gbG9j
YWxob3N0IChbNjIuOTYuNjUuMTE5XSkKICAgICAgICBieSBzbXRwLmdtYWls
LmNvbSB3aXRoIEVTTVRQU0EgaWQgczE2c201MjA3NTY0ZWpyLjMxLjIwMjAu
MDcuMjcuMDAuMjAuMjIKICAgICAgICAodmVyc2lvbj1UTFMxXzMgY2lwaGVy
PVRMU19BRVNfMjU2X0dDTV9TSEEzODQgYml0cz0yNTYvMjU2KTsKICAgICAg
ICBNb24sIDI3IEp1bCAyMDIwIDAwOjIwOjIyIC0wNzAwIChQRFQpCkRhdGU6
IE1vbiwgMjcgSnVsIDIwMjAgMDk6MjA6MjEgKzAyMDAKRnJvbTogVGhpZXJy
eSBSZWRpbmcgPHRoaWVycnkucmVkaW5nQGdtYWlsLmNvbT4KVG86IEtvbnN0
YW50aW4gUnlhYml0c2V2IHZpYSBSVCA8a2VybmVsLWhlbHBkZXNrQHJ0Lmxp
bnV4Zm91bmRhdGlvbi5vcmc+CkNjOiB1LmtsZWluZS1rb2VuaWdAcGVuZ3V0
cm9uaXguZGUsIGxpbnV4LXB3bUB2Z2VyLmtlcm5lbC5vcmcKU3ViamVjdDog
UmU6IFtLZXJuZWwub3JnIEhlbHBkZXNrICM4OTk0Ml0gUmU6IGFkZGluZyBs
aW51eC1wd20gYXJjaGl2ZXMgdG8KIGxvcmUua2VybmVsLm9yZz8KTWVzc2Fn
ZS1JRDogPDIwMjAwNzI3MDcyMDIxLkdBMjc4MDcxNUB1bG1vPgpSZWZlcmVu
Y2VzOiA8MjAyMDAyMTMxMDI2MTgueDVqNmtmdnFtZGJ4MnByMkBwZW5ndXRy
b25peC5kZT4KIDwyMDIwMDUyMzE3MDU1OC5oMmJycWxmMmp4NGtlZTZ5QHBl
bmd1dHJvbml4LmRlPgogPDIwMjAwNjEzMTQxNTMzLmFrM255bzVodTYzNmV2
d3FAdGF1cnVzLmRlZnJlLmtsZWluZS1rb2VuaWcub3JnPgogPDIwMjAwNzA5
MDkyNjU5LmRycm12djUzcXMycTRsaWRAcGVuZ3V0cm9uaXguZGU+CiA8cnQt
NC40LjAtMTY4Ni0xNTk0Mjg2ODI2LTExNjcuODk5NDItNi0wQGxpbnV4Zm91
bmRhdGlvbj4KIDwwMTAxMDE3MzRmMzk3ZjAwLTM5ZDU0YTgxLWQwNmQtNDk0
Ny1iOWZjLTMzMmU5ZjliNDZkNS0wMDAwMDBAdXMtd2VzdC0yLmFtYXpvbnNl
cy5jb20+CiA8MjAyMDA3MjMxNzI3MDIubmlybmV0NnRibXd1d2Q1N0BwZW5n
dXRyb25peC5kZT4KIDwwMTAxMDE3MzdjYjZkOTg4LWJiNzBkNTE3LWJiZjgt
NDRiMC1hYTNkLTRmOWVlZDkxMDFmMy0wMDAwMDBAdXMtd2VzdC0yLmFtYXpv
bnNlcy5jb20+CiA8MjAyMDA3MjMxNzM4NDEuNGdlZzRibG5nYzJmd3A0ekBj
aGF0dGVyLmk3LmxvY2FsPgogPDAxMDEwMTczN2NjMThiNGItM2M3OGI0MWMt
MzA5ZS00ZDYyLWI2YWYtZmQwNTM2MjkxZWFiLTAwMDAwMEB1cy13ZXN0LTIu
YW1hem9uc2VzLmNvbT4KTUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1UeXBl
OiBtdWx0aXBhcnQvc2lnbmVkOyBtaWNhbGc9cGdwLXNoYTI1NjsKCXByb3Rv
Y29sPSJhcHBsaWNhdGlvbi9wZ3Atc2lnbmF0dXJlIjsgYm91bmRhcnk9Ilcv
bnpCWk81ekMwdU1TZUEiCkNvbnRlbnQtRGlzcG9zaXRpb246IGlubGluZQpJ
bi1SZXBseS1UbzogPDAxMDEwMTczN2NjMThiNGItM2M3OGI0MWMtMzA5ZS00
ZDYyLWI2YWYtZmQwNTM2MjkxZWFiLTAwMDAwMEB1cy13ZXN0LTIuYW1hem9u
c2VzLmNvbT4KVXNlci1BZ2VudDogTXV0dC8xLjE0LjQgKDIwMjAtMDYtMTgp
CgoKLS1XL256QlpPNXpDMHVNU2VBCkNvbnRlbnQtVHlwZTogdGV4dC9wbGFp
bjsgY2hhcnNldD11dGYtOApDb250ZW50LURpc3Bvc2l0aW9uOiBpbmxpbmUK
Q29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogcXVvdGVkLXByaW50YWJsZQoK
T24gVGh1LCBKdWwgMjMsIDIwMjAgYXQgMDU6Mzg6NDVQTSArMDAwMCwgS29u
c3RhbnRpbiBSeWFiaXRzZXYgdmlhIFJUIHdyb3RlOgo+IE9uIFRodSwgSnVs
IDIzLCAyMDIwIGF0IDA1OjI3OjA0UE0gKzAwMDAsIFV3ZSBLbGVpbmUtSz1D
Mz1CNm5pZyB2aWEgUlQgd3I9Cm90ZToKPiA+ID4gSSdtIHNvcnJ5LCBhcHBh
cmVudGx5IEkgc2NyZXdlZCB1cCBhbmQgZGlkbid0IGFzc2lnbiB0aGlzIHRp
Y2tldCB0bwo+ID4gPiBhbnlvbmUgd2hlbiBpdCBjYW1lIGluLiBJIHdhcyBk
dXRpZnVsbHkgaWdub3JpbmcgZm9sbG93LXVwcywgYXMgSSdkCj4gPiA+IGFz
c3VtZWQgc29tZW9uZSBlbHNlIHdvdWxkIGJlIHJlc3BvbmRpbmcuCj4gPiA+
PTIwCj4gPiA+IENocmlzLCBJJ3ZlIHByb3Blcmx5IGFzc2lnbmVkIGl0IHRv
IHlvdSBub3cgLS0gY2FuIHlvdSBwbGVhc2UKPiA+ID4gcHJpb3JpdGlzZSB0
aGlzIHJlcXVlc3QsIGFzIHRpbWUgYWxsb3dzPwo+ID49MjAKPiA+IExhc3Qg
d2VlayBJIHRob3VnaHQgdGhpcyBpcyBhIG5vLWJyYWluZXIgbm93IGFuZCB3
aWxsIGJlIGRvbmUgaW4gYSBmZXcKPiA+IGhvdXJzLiBJdCBzZWVtcyBJIHdh
cyB3cm9uZyA6LXwKPj0yMAo+IEkgZG8gYXBwcmVjaWF0ZSB5b3VyIHBhdGll
bmNlLiBUaGVyZSBpcyBhIGxvdCBvZiBvdGhlciB3b3JrIGhhcHBlbmluZyBh
dD0KPTIwCj4gdGhlIElUIHRlYW0sIHNvIHlvdXIgcmVxdWVzdCBmb3IgYWRk
aW5nIGEgbWFpbGluZyBsaXN0IGFyY2hpdmUgaGFzIHRvPTIwCj4gY29udGVu
ZCBmb3Igc3RhZmYgcmVzb3VyY2VzIHdpdGggbWFueSBvdGhlciBvbmdvaW5n
IHByb2plY3RzLgoKV2UndmUgbWFkZSBkbyB3aXRob3V0IHRoZSBhcmNoaXZl
IHVwIHRvIG5vdywgc28gSSB0aGluayB3ZSBjYW4gd2FpdCBhCmJpdCBsb25n
ZXIuIEkgdGhpbmsgVXdlIG1pZ2h0IGp1c3QgYmUgd29ycmllZCB0aGF0IHRo
aXMgZmVsbCB0aHJvdWdoIHRoZQpjcmFja3MgYWdhaW4uIElmIGl0IGRpZG4n
dCwgSSdtIHN1cmUgd2UgY2FuIGJlIHBhdGllbnQgZm9yIGEgYml0IGxvbmdl
ci4KClRoaWVycnkKCi0tVy9uekJaTzV6QzB1TVNlQQpDb250ZW50LVR5cGU6
IGFwcGxpY2F0aW9uL3BncC1zaWduYXR1cmU7IG5hbWU9InNpZ25hdHVyZS5h
c2MiCgotLS0tLUJFR0lOIFBHUCBTSUdOQVRVUkUtLS0tLQoKaVFJekJBQUJD
QUFkRmlFRWlPckRDQUZKelBmQWpjaWYzU09zMTM4K3M2RUZBbDhlZ0RJQUNn
a1EzU09zMTM4KwpzNkdFakEvK1B4WG5WN0lRbFNOd1FWQWl6NjVXUTRvSkYw
dEx5Y3NpaXZSSi9qeXhCcFdRb3hvMzZOY0RreUp5CnVSMldCSUdSdkZaRlMy
UGFKOGF4VlpDQVR5MENYOE14NGZTUjdzQUlxdTB4MEdJUnJTeFVBMU9GSjlE
ZEtkdlQKdWlvaGRHYjZDS0d3MnRubzhnUWZtZFRXTXBiL0VDQTVwUzQwSDJ5
UThOenhOdExJUFNMWncxZ214ODl6b2UyWQoxWE9LSDlmTUFLcTM3ZXh5YWt1
alo1N1FLSUpydkNTd0M2WHh6dlRCWldUdjE0SlFxREFncHdhZEttRWtndndr
CmRxRXkrcDhvT2hnQ2VrR1VkK1VzZnFmb0l0VExYdlVWRXlaWFRCeFAvT2VQ
QVIxU1VadUVyRzZWYU9yL2pFbm0KejJPQzE3alhyZ2VTMm93RGh0MWQveW1W
Ty94bWVNbG9XZExYZFpjVzFTSUZ2OEVnUHRFRmlhY3htb1RaVkR3LwpyTTJ4
M3htNE04ZDJEYVd2TDNBRjhFbXVtbVNycDBadDlKbitEelFBOW5QNGNkK3pN
YlMraHl0TnBPVkVmTkY4CkJOTzVXYlV6Q1hyWXNBaTdFcVozR3R4bDRkMk9n
TStkaDRXb0JuVkNlN1U3SEtiRmpyazdCRFZ1anpRdENDWDQKUVVHaTR2Q0dh
ZHBsc3pwVWsyR0VNdHYwMHQ2UW9laGQzMHg1eUVHR1dza1RHdHhac1ZLdXlI
Q214UmVIVkxuNAppTnA1Z0VGUGtpcFNXYnVWS29ZMk8xWlJJNkg0N29Tbllv
TGlMVVhISDdMbU53OGpDUEVrL1V4YWp1M1ordDYxCmNoNjllWEFuWWdxV1pD
d1JIL1J1YnhUNkNXQUJldldDSVZDK2lGS01KSHBnSnllem1XTT0KPUtNTnAK
LS0tLS1FTkQgUEdQIFNJR05BVFVSRS0tLS0tCgotLVcvbnpCWk81ekMwdU1T
ZUEtLQo=

------------=_1595834426-25457-3734--
